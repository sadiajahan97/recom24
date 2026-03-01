import os
from typing import Optional

import chromadb
from chromadb import ClientAPI


def get_chroma_client() -> ClientAPI:
    base_dir = os.path.dirname(os.path.abspath(__file__))
    default_path = os.path.join(base_dir, "chroma-data")
    path = os.getenv("CHROMA_DB_DIR", default_path)

    return chromadb.PersistentClient(path=path)


def get_collection(
    name: str = "default",
    *,
    metadata: Optional[dict] = None,
):
    client = get_chroma_client()
    return client.get_or_create_collection(name=name, metadata=metadata or {})

