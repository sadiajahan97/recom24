from fastapi import APIRouter, Depends, HTTPException
from datetime import datetime
from typing import List

from auth import verify_access_token
from db import get_db
from prisma import Prisma
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

    return RecommendationItem(
        id=updated.id,
        description=updated.description,
        isComplete=updated.isComplete,
        link=updated.link,
        title=updated.title,
        type=updated.type,
        createdAt=updated.createdAt,
    )
