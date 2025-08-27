from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

# FastAPI Application 생성
app = FastAPI()

# Flutter 에서 빌드된 파일 제공
app.mount("/", StaticFiles(directory="build/web", html=True), name="web") # root로부터 시작

if __name__ == "__main__":
  import uvicorn
  uvicorn.run(app, host='127.0.0.1', port=8000)