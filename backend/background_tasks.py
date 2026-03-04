import asyncio
import uuid
from datetime import datetime
from typing import List

import requests

from articles import generate_articles
from courses import generate_courses
from videos import generate_videos
from chroma import get_collection
from prisma import Prisma
from pydantic import BaseModel
from professions import query_profession_description


def is_url_accessible(url: str) -> bool:
    try:
        response = requests.head(url, timeout=5)
        return response.status_code < 400
    except requests.RequestException:
        return False


async def process_recommendations(
    items: List[BaseModel], category: str
) -> None:
    collection = get_collection("recommendations")
    for item in items:
        item_id = str(uuid.uuid4())
        now = datetime.now()

        item_dict = item.model_dump()
        description = item_dict.get("description", "")
        link = item_dict.get("link", "")
        profession = item_dict.get("profession", "")
        title = item_dict.get("title", "")

        if not link or not await asyncio.to_thread(is_url_accessible, link):
            continue

        embedding_text = f"Title: {title}\nDescription: {description}\nType: {category}\nProfession: {profession}"

        metadata = {
            "description": description,
            "link": link,
            "profession": profession,
            "title": title,
            "type": category,
            "createdAt": now.isoformat(),
        }

        collection.add(
            ids=[item_id],
            documents=[embedding_text],
            metadatas=[metadata],
        )


async def generate_and_store_recommendations() -> None:
    articles_task = asyncio.to_thread(generate_articles)
    courses_task = asyncio.to_thread(generate_courses)
    videos_task = asyncio.to_thread(generate_videos)

    articles, courses, videos = await asyncio.gather(
        articles_task, courses_task, videos_task
    )

    await asyncio.gather(
        process_recommendations(articles, "article"),
        process_recommendations(courses, "course"),
        process_recommendations(videos, "video"),
    )


async def generate_user_recommendations(
    user_id: str, profession: str, db: Prisma
) -> None:
    profession_desc = query_profession_description(profession)
    if profession_desc is None:
        print(
            f"[recommendations] No profession description found for '{profession}', skipping recommendations."
        )
        return

    collection = get_collection("recommendations")
    embedding_text = (
        f"Profession: {profession_desc.profession}\n"
        f"Job Description: {profession_desc.job_description}"
    )

    result = collection.query(
        query_texts=[embedding_text],
        n_results=24,
        include=["metadatas", "distances"],
    )

    ids = result.get("ids") or []
    metadatas = result.get("metadatas") or []
    distances = result.get("distances") or []

    if not ids or not ids[0]:
        print(
            f"[recommendations] No recommendations found in vector DB for user {user_id} and profession '{profession}'."
        )
        return

    max_recommendations = 24

    for _rec_id, meta, distance in zip(
        ids[0], (metadatas[0] or []), (distances[0] or [])
    ):
        if distance is None or distance > 0.5:
            continue

        meta = meta or {}
        description = meta.get("description", "")
        link = meta.get("link", "")
        title = meta.get("title", "")
        rec_type = meta.get("type", "unknown")

        if not link:
            print(
                f"[recommendations] Skipping recommendation for user {user_id} due to missing link."
            )
            continue

        await db.recommendation.create(
            data={
                "description": description,
                "link": link,
                "title": title,
                "type": rec_type,
                "userId": user_id,
            }
        )

        max_recommendations -= 1
        if max_recommendations <= 0:
            break


async def schedule_recommendations() -> None:
    while True:
        try:
            await generate_and_store_recommendations()
            print("[recommendations] Successfully generated recommendations batch.")
        except Exception as exc:
            print(f"[recommendations] Error while generating recommendations: {exc}")

        await asyncio.sleep(5 * 60)


async def schedule_user_recommendations(
    user_id: str, profession: str, db: Prisma
) -> None:
    while True:
        try:
            await generate_user_recommendations(user_id, profession, db)
            print(
                f"[recommendations] Stored top recommendation for user {user_id} (profession='{profession}')."
            )
        except Exception as exc:
            print(
                f"[recommendations] Error while storing recommendation for user {user_id}: {exc}"
            )

        await asyncio.sleep(24 * 60 * 60)
