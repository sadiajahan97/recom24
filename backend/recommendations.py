from fastapi import APIRouter, Depends
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


class RecommendationResponse(BaseModel):
    articles: List[Article]
    courses: List[Course]
    videos: List[Video]


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
) -> RecommendationResponse:
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

    return RecommendationResponse(
        articles=articles,
        courses=courses,
        videos=videos,
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

    articles: List[Article] = []
    courses: List[Course] = []
    videos: List[Video] = []

    for rec in records:
        if rec.type == "article":
            articles.append(
                Article(
                    title=rec.title,
                    description=rec.description,
                    image=rec.image or "",
                    link=rec.link,
                )
            )
        elif rec.type == "course":
            courses.append(
                Course(
                    title=rec.title,
                    description=rec.description,
                    image=rec.image or "",
                    link=rec.link,
                )
            )
        elif rec.type == "video":
            videos.append(
                Video(
                    title=rec.title,
                    description=rec.description,
                    link=rec.link,
                )
            )

    return RecommendationResponse(
        articles=articles,
        courses=courses,
        videos=videos,
    )
