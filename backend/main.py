from contextlib import asynccontextmanager

from dotenv import load_dotenv
from fastapi import FastAPI

load_dotenv()
from prisma import Prisma

from auth import router as auth_router
from recommendations import router as recommendations_router
from db import set_db

prisma = Prisma()


@asynccontextmanager
async def lifespan(app: FastAPI):
    await prisma.connect()
    set_db(prisma)
    yield
    await prisma.disconnect()


app = FastAPI(
    title="Recom24 API",
    description="FastAPI backend for Recom24",
    version="0.1.0",
    lifespan=lifespan,
)

app.include_router(auth_router)
app.include_router(recommendations_router)


@app.get("/")
async def root():
    return {"message": "Hello from Recom24 API"}


@app.get("/health")
async def health():
    return {"status": "ok"}
