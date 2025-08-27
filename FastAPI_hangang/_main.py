"""
author : smitepaladin Jun Jong Eck
description : FastAPI for Hangang Project
date : 2025.08.19
version : 1.0
"""

from fastapi import FastAPI
from user import router as user_router
from fastapi.middleware.cors import CORSMiddleware
import pymysql





app = FastAPI()
app.include_router(user_router, prefix="/user", tags=['user'])


# CORS (필요 시 조정)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # 개발용
    allow_methods=["*"],
    allow_headers=["*"],
)


if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)



