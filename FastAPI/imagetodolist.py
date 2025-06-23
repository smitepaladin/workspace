"""
author:smitepaladin
description:lecture
date:2025/05/15
version:1.0
"""

from fastapi import FastAPI
from pydantic import BaseModel # 클래스를 만들 수 있다.
import pymysql

app = FastAPI()

class ImageTodoList(BaseModel): # 이 모양으로 데이터를 받아서 쓸 수 있다. url이 감춰지는 post방식
  contents: str
  image : str
  insertdate : str


class ImageTodoListCode(BaseModel): # 삭제를 위한 class
  seq : int


def connect(): # 데이터베이스에 연결
  conn = pymysql.connect(
    host="127.0.0.1",
    user="root",
    password="qwer1234",
    db="python",
    charset="utf8"
  )
  return conn

@app.get("/select") # url에 적히는 부분, 데이터베이스 받아서 넘겨주면 된다
async def select():
  # Connection부터 해줘야한다.
  conn = connect()
  # 데이터를 실행하려면 커서가 무조건 필요하다.
  curs = conn.cursor()

  # SQL문장
  sql = "SELECT * FROM imagetodolist"
  # 커서를 통해 실행
  curs.execute(sql)
  rows = curs.fetchall() # 결과를 받아서 넣어준다.
  conn.close() # 데이터베이스랑 연결 끊기
  # return rows # 이대로 주면 프론트가 고생한다.
  # print(rows)
  # 결과값을 Dictionary로 변환
  result = [{'seq':row[0], 'contents': "" if row[1] == None else row[1], 'image': "" if row[2] == None else row[2], 'insertdate': "" if row[3] == None else row[3]} for row in rows]

  return {'results' : result}
##### 여기까지 select

@app.post("/insert")
async def insert(imagetodolist: ImageTodoList):
  # Connction
  conn = connect()
  curs = conn.cursor()


  # SQL
  try:
    sql = "INSERT INTO imagetodolist(contents, image, insertdate) values (%s,%s,%s)"
    ## 
    curs.execute(sql, (imagetodolist.contents, imagetodolist.image, imagetodolist.insertdate))
    conn.commit()
    conn.close()
    return {'result' : 'OK'}
  except Exception as ex:
    conn.close()
    print("Error :", ex)
    return {'result' : 'Error'}
##### 여기까지 insert

if __name__=="__main__":
  import uvicorn
  uvicorn.run(app, host="127.0.0.1", port=8000)