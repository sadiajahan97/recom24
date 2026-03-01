import os
from typing import Optional

import chromadb
from chromadb import ClientAPI

from embedding import get_embedding_function


def get_chroma_client() -> ClientAPI:
    base_dir = os.path.dirname(os.path.abspath(__file__))
    default_path = os.path.join(base_dir, "chroma-data")
    path = os.getenv("CHROMA_DB_DIR", default_path)

    return chromadb.PersistentClient(path=path)


def get_collection(
    name: str = "default",
    *,
    metadata: Optional[dict] = None,
    embedding_function=None,
):
    client = get_chroma_client()
    ef = embedding_function if embedding_function is not None else get_embedding_function()
    return client.get_or_create_collection(
        name=name,
        metadata=metadata or {},
        embedding_function=ef,
    )

