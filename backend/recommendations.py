from fastapi import APIRouter, Depends, HTTPException
import asyncio
import uuid
from datetime import datetime
from typing import List

from courses import generate_courses_from_query, Course
from articles import generate_articles_from_query, Article
from videos import generate_videos_from_query, Video
from auth import verify_access_token
from db import get_db
from prisma import Prisma
from chroma import get_collection
from pydantic import BaseModel

router = APIRouter(prefix="/recommendations", tags=["recommendations"])


class RecommendationItem(BaseModel):
    id: str
    description: str
    isComplete: bool
    link: str
    title: str
    type: str
    createdAt: datetime


class RecommendationResponse(BaseModel):
    items: List[RecommendationItem]


async def process_recommendations(
    items: List[BaseModel], category: str, user_id: str, db: Prisma
) -> None:
    collection = get_collection("recommendations")
    for item in items:
        item_id = str(uuid.uuid4())
        now = datetime.now()

        item_dict = item.model_dump()
        description = item_dict.get("description", "")
        image = item_dict.get("image")
        link = item_dict.get("link", "")
        title = item_dict.get("title", "")

        await db.recommendation.create(
            data={
                "id": item_id,
                "description": description,
                "image": image,
                "link": link,
                "title": title,
                "type": category,
                "userId": user_id,
            }
        )

        embedding_text = f"Title: {title}\nDescription: {description}\nType: {category}"

        metadata = {
            "id": item_id,
            "description": description,
            "image": image or "",
            "isComplete": False,
            "link": link,
            "title": title,
            "type": category,
            "createdAt": now.isoformat(),
            "updatedAt": now.isoformat(),
            "userId": user_id,
        }

        collection.add(
            ids=[item_id],
            documents=[embedding_text],
            metadatas=[metadata],
        )


async def generate_and_store_recommendations_for_user(
    user_id: str, query: str, db: Prisma
) -> None:
    articles_task = asyncio.to_thread(generate_articles_from_query, query)
    courses_task = asyncio.to_thread(generate_courses_from_query, query)
    videos_task = asyncio.to_thread(generate_videos_from_query, query)

    articles, courses, videos = await asyncio.gather(
        articles_task, courses_task, videos_task
    )

    await asyncio.gather(
        process_recommendations(articles, "article", user_id, db),
        process_recommendations(courses, "course", user_id, db),
        process_recommendations(videos, "video", user_id, db),
    )


async def schedule_recommendations_for_user(
    user_id: str, db: Prisma, query: str = "python"
) -> None:
    while True:
        try:
            await generate_and_store_recommendations_for_user(user_id, query, db)
        except Exception as exc:
            print(f"[recommendations] Error while generating for user {user_id}: {exc}")

        await asyncio.sleep(8 * 60 * 60)


@router.get("/", response_model=RecommendationResponse)
async def get_recommendations(
    user_id: str = Depends(verify_access_token),
    db: Prisma = Depends(get_db),
) -> RecommendationResponse:
    records = await db.recommendation.find_many(
        where={"userId": user_id},
        order={"createdAt": "desc"},
    )

    items = [
        RecommendationItem(
            id=rec.id,
            description=rec.description,
            isComplete=rec.isComplete,
            link=rec.link,
            title=rec.title,
            type=rec.type,
            createdAt=rec.createdAt,
        )
        for rec in records
    ]

    return RecommendationResponse(items=items)


@router.patch("/{recommendation_id}/complete", response_model=RecommendationItem)
async def mark_recommendation_as_complete(
    recommendation_id: str,
    user_id: str = Depends(verify_access_token),
    db: Prisma = Depends(get_db),
) -> RecommendationItem:
    rec = await db.recommendation.find_first(
        where={"id": recommendation_id, "userId": user_id},
    )
    if not rec:
        raise HTTPException(status_code=404, detail="Recommendation not found.")

    updated = await db.recommendation.update(
        where={"id": recommendation_id},
        data={"isComplete": True},
    )

    try:
        collection = get_collection("recommendations")
        existing = collection.get(ids=[recommendation_id])
        metadatas = existing.get("metadatas") or []
        if metadatas:
            metadata = {
                **metadatas[0],
                "isComplete": True,
                "updatedAt": datetime.now().isoformat(),
            }
        else:
            metadata = {
                "id": recommendation_id,
                "isComplete": True,
                "updatedAt": datetime.now().isoformat(),
                "userId": user_id,
            }

        collection.update(
            ids=[recommendation_id],
            metadatas=[metadata],
        )
    except Exception as exc:
        print(
            f"[recommendations] Failed to update Chroma for recommendation {recommendation_id}: {exc}"
        )

    return RecommendationItem(
        id=updated.id,
        description=updated.description,
        isComplete=updated.isComplete,
        link=updated.link,
        title=updated.title,
        type=updated.type,
        createdAt=updated.createdAt,
    )
