import json
import uuid
from typing import Optional

from pydantic import BaseModel, Field

from chroma import get_collection
from llm import client, config


class ProfessionDescription(BaseModel):
    profession: str = Field(description="The name of the profession")
    job_description: str = Field(
        description=(
            "A detailed job description including key knowledge areas, "
            "responsibilities, and required skills for the profession"
        )
    )


def generate_job_description(profession: str) -> ProfessionDescription:
    prompt = (
        f"You are a career guidance expert.\n\n"
        f"Describe the profession: '{profession}'.\n\n"
        "Your description must clearly cover:\n"
        "- The core knowledge areas required\n"
        "- The main responsibilities typically handled in this role\n"
        "- The key skills (both technical and soft) that are important\n\n"
        "Return your answer ONLY as a valid JSON object with exactly these keys:\n"
        "  - 'profession': the name of the profession as a string\n"
        "  - 'job_description': a single, cohesive text string that explains\n"
        "    the knowledge, responsibilities, and skills required for the role.\n"
        "Do not include any extra keys, commentary, or markdown. Only output JSON."
    )

    response = client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt,
        config=config,
    )

    text = response.text.strip()
    if text.startswith("```json"):
        text = text[len("```json") :].strip()
    if text.endswith("```"):
        text = text[:-3].strip()

    result_dict = json.loads(text)
    return ProfessionDescription(**result_dict)


def store_profession_description(profession_description: ProfessionDescription) -> None:
    collection = get_collection("professions")

    item_id = str(uuid.uuid4())
    embedding_text = (
        f"Profession: {profession_description.profession}\n"
        f"Job Description: {profession_description.job_description}"
    )

    metadata = {
        "profession": profession_description.profession,
        "job_description": profession_description.job_description,
    }

    collection.add(
        ids=[item_id],
        documents=[embedding_text],
        metadatas=[metadata],
    )


def query_profession_description(
    profession: str,
) -> Optional[ProfessionDescription]:
    collection = get_collection("professions")
    result = collection.query(
        query_texts=[profession],
        n_results=1,
        include=["metadatas", "distances"],
    )

    ids = result.get("ids") or []
    metadatas = result.get("metadatas") or []
    distances = result.get("distances") or []

    if not ids or not ids[0]:
        return None

    meta = (metadatas[0] or [None])[0] or {}
    distance = (distances[0] or [None])[0]

    if distance is None or distance > 0.1:
        return None

    stored_profession = meta.get("profession", profession)

    job_description = meta.get("job_description")
    if not job_description:
        return None

    return ProfessionDescription(
        profession=stored_profession,
        job_description=job_description,
    )

