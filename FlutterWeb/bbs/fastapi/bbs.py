"""
author : Smite Paladin
Description : MySQL의 python Database와 CRUD on Web
"""


from fastapi import FastAPI
import pymysql
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware

app = FastAPI()

# CORS 설정
app.add_middleware(
  CORSMiddleware,
  allow_origins = ['*'], # 모든 도메인 허용
  allow_credentials = True,
  allow_methods = ['*'], # 모든 http method 허용
  allow_headers = ['*'], # 모든 헤더 허용
)


def connect():
  # MySQL Connection
  conn = pymysql.connect(
    host='127.0.0.1',
    user='root',
    password='qwer1234',
    db='flutter',
    charset='utf8'
  )
  return conn



class Board(BaseModel):
    bName: str
    bTitle: str
    bContent: str
    bDate: str




@app.get("/select")
async def select(page: int = 1, size: int = 8):
    offset = (page - 1) * size
    conn = connect()
    curs = conn.cursor()

    # 전체 갯수 먼저 가져오기
    curs.execute("SELECT COUNT(*) FROM board")
    total_count = curs.fetchone()[0]

    # 원하는 페이지 데이터만 가져오기
    sql = """
        SELECT bId, bName, bTitle, bContent, bDate 
        FROM board 
        ORDER BY bId DESC
        LIMIT %s OFFSET %s
    """
    curs.execute(sql, (size,offset))
    rows = curs.fetchall()

    # 컬럼 이름 가져오기
    column_names = [desc[0] for desc in curs.description]

    # 데이터 처리
    results = [dict(zip(column_names, row)) for row in rows]
    conn.close()

    # 결과에 total_count 추가
    return {
        "total": total_count,
        "results": results
    }



@app.post("/insert")
async def insert(board: Board):
    try:
        conn = connect()
        curs = conn.cursor()
        sql = "INSERT INTO board (bName, bTitle, bContent, bDate) VALUES (%s, %s, %s, %s)"
        curs.execute(sql, (board.bName, board.bTitle, board.bContent, board.bDate))
        conn.commit()
        conn.close()
        return {"result": "OK"}
    except Exception as e:
        print("Error:", e)
        return {"result": "Error"}


@app.post("/update/{bId}")
async def update(bId: int, board: Board):
    try:
        conn = connect()
        curs = conn.cursor()
        sql = "UPDATE board SET bName=%s, bTitle=%s, bContent=%s, bDate=%s WHERE bId=%s"
        curs.execute(sql, (board.bName, board.bTitle, board.bContent, board.bDate, bId))
        conn.commit()
        conn.close()
        return {"result": "OK"}
    except Exception as e:
        print("Error:", e)
        return {"result": "Error"}


@app.post("/delete/{bId}")
async def delete(bId: int):
    try:
        conn = connect()
        curs = conn.cursor()
        sql = "DELETE FROM board WHERE bId = %s"
        curs.execute(sql, (bId,))
        conn.commit()
        conn.close()
        return {"result": "OK"}
    except Exception as e:
        print("Error:", e)
        return {"result": "Error"}


# 파이썬 메인 함수
if __name__ == "__main__":
  import uvicorn
  uvicorn.run(app, host="127.0.0.1", port=8000)