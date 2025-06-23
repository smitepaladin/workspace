# async방식, 함수앞에 async만 적어주면 된다
from fastapi import FastAPI

app = FastAPI() # 생성자를 통해 객체 만듬

@app.get("/")
async def read_root():
  return{"message" : "Hellow, World!"}

@app.get("/items/{item_id}") ## URL에서 데이터 받는것 가능
async def read_item(item_id: int, quary_param: str = None):
  return {"item_id" : item_id, "quary_param" : quary_param} # http://127.0.0.1:8000/items/42/


if __name__=="__main__":
  import uvicorn
  uvicorn.run(app, host="127.0.0.1", port=8000) # 앱을 실행할거야, fastapi는 8000번포트, 안드로이드는 127.0.0.1을 못잡음