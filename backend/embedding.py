from chromadb.utils.embedding_functions import SentenceTransformerEmbeddingFunction

BGE_MODEL_NAME = "BAAI/bge-small-en-v1.5"


def get_embedding_function() -> SentenceTransformerEmbeddingFunction:
    return SentenceTransformerEmbeddingFunction(model_name=BGE_MODEL_NAME)
