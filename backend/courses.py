from typing import List
from pydantic import BaseModel, Field
from llm import client, config
import json

class Course(BaseModel):
    title: str = Field(description="The title of the course")
    description: str = Field(description="A brief description of the course content")
    image: str = Field(description="A placeholder or suggested image URL/theme for the course")
    link: str = Field(description="A link to the course")

class CourseList(BaseModel):
    courses: List[Course]

def generate_courses_from_query(query: str) -> List[Course]:
    prompt = (
        f"Research and find a list of exactly eight highly relevant and real-world courses (from platforms like Coursera, Udemy, edX, etc.) for the topic: {query}. "
        "Return the result as a JSON object with a 'courses' key containing a list of objects. "
        "Each object must have exactly these fields: 'title', 'description', 'image' (a placeholder or suggested theme), and 'link'. "
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
    return CourseList(**result_dict).courses
