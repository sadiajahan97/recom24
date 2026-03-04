from typing import List
from pydantic import BaseModel, Field
from llm import client, config
import json

class Article(BaseModel):
    title: str = Field(description="The title of the article")
    description: str = Field(description="A brief description of the article content")
    link: str = Field(description="A link to the article")
    profession: str = Field(description="The profession this article is relevant for")

class ArticleList(BaseModel):
    articles: List[Article]

def generate_articles() -> List[Article]:
    prompt = (
        "Pick one random profession. "
        "Research and find a list of exactly eight highly relevant and real-world articles for that profession. "
        "Return the result as a JSON object with an 'articles' key containing a list of objects. "
        "Each object must have exactly these fields: 'title', 'description', 'link', and 'profession' "
        "(where 'profession' is the profession the article is relevant for). "
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
    return ArticleList(**result_dict).articles
