from typing import List
from pydantic import BaseModel, Field
from llm import client, config
import json

class Article(BaseModel):
    title: str = Field(description="The title of the article")
    description: str = Field(description="A brief description of the article content")
    image: str = Field(description="A placeholder or suggested image URL/theme for the article")
    link: str = Field(description="A link to the article")

class ArticleList(BaseModel):
    articles: List[Article]

def generate_articles_from_query(query: str) -> List[Article]:
    prompt = (
        f"Research and find a list of exactly eight highly relevant and real-world articles for the topic: {query}. "
        "Return the result as a JSON object with an 'articles' key containing a list of objects. "
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
    return ArticleList(**result_dict).articles
