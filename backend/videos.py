from typing import List
from pydantic import BaseModel, Field
from llm import client, config
import json

class Video(BaseModel):
    title: str = Field(description="The title of the video")
    description: str = Field(description="A brief description of the video content")
    link: str = Field(description="A link to the video")

class VideoList(BaseModel):
    videos: List[Video]

def generate_videos(profession: str) -> List[Video]:
    prompt = (
        f"Research and find a list of exactly eight highly relevant and real-world videos (e.g. from YouTube) for the given profession: {profession}. "
        "Return the result as a JSON object with a 'videos' key containing a list of objects. "
        "Each object must have exactly these fields: 'title', 'description', and 'link'. "
        "Ensure the output is ONLY valid JSON."
    )
    
    response = client.models.generate_content(
        model="gemini-2.5-flash",
        contents=prompt,
        config=config
    )
    
    text = response.text.strip()
    if text.startswith("```json"):
        text = text[len("```json"):].strip()
    if text.endswith("```"):
        text = text[:-3].strip()
        
    result_dict = json.loads(text)
    return VideoList(**result_dict).videos
