from fastapi import FastAPI, UploadFile, File, Form
# 프론트에서 날아오는 데이터를 모두 하나의 Form으로 받는다. MODEL이 필요없다.
# 심지어 데이터를 나눠서 보낼 수 있다. FastAPI는 async니까.

from fastapi.responses import Response
# 이미지 검색해서 보여줄 때 씀

import pymysql

app = FastAPI()
# 객체생성

def connect():
  return pymysql.connect(
    host="127.0.0.1",
    user="root",
    password="qwer1234",
    db="python",
    charset="utf8"
  )

@app.get("/select")
async def select():
  conn = connect()
  curs = conn.cursor()
  curs.execute("SELECT seq, name, phone, address, relation FROM address ORDER BY name")
  # 이미지는 안 가지고 왔다. 퍼포먼스를 위해
  rows = curs.fetchall()
  conn.close()
  result = [{'seq':row[0], 'name':row[1], 'phone':row[2], 'address':row[3], 'relation':row[4]} for row in rows]
  return {'results' : result}

# 이제 이미지를 가져오자.

@app.get("/view/{seq}")
async def view(seq: int):
  # 이미지는 select라도 try를 해야한다.
  
  try:
    conn = connect()
    curs = conn.cursor()
    curs.execute("SELECT image FROM address where seq = %s",(seq, ))
    # 튜플타입으로 만들기 위해 일부러 (seq, ) 를 했다. (seq)로 하면 integer라 수정불가
    row = curs.fetchone()
    conn.close()
    # return 경우의 수 3개발생. 이미지 넣은경우, 안넣은경우, 에러난경우
    if row and row[0]:
      # 이미지 보낸다.
      return Response(
        content = row[0],
        media_type="image/jpeg",
        headers={"Cache-control" : "no-cache, no-store, must-revalidate"}
        # 캐시 안 쓰게, 저장도 안하게, 데이터베이스의 BLOB에는 헤더가 없으니까 헤더를 붙여서 보내준다.
      )
    else: # 이미지 없는경우
      return {"result":"No image found"}
  except Exception as e: # 에러난경우
    print("Error :", e)
    return {"result" : "Error"}

@app.post("/insert")
async def insert(name: str=Form(...), phone: str=Form(...), address: str=Form(...), relation: str=Form(...), file: UploadFile = File(...)):
  try:
    image_data = await file.read()
    conn = connect()
    curs = conn.cursor()
    sql = "INSERT INTO address (name, phone, address, relation, image) VALUES (%s,%s,%s,%s,%s)" # 이미지도 string타입으로 가져온다.
    curs.execute(sql, (name, phone, address, relation, image_data))
    conn.commit()
    conn.close()
    return {"result" : "OK"}
  except Exception as e:
    print("Error", e)
    return {"result" : "Error"}


@app.post("/update")
async def update(seq: int = Form(...), name: str = Form(...), phone: str = Form(...), address: str = Form(...), relation: str = Form(...)):
  try:
    conn = connect()
    curs = conn.cursor()
    sql = "UPDATE address SET name=%s, phone=%s, address=%s, relation=%s WHERE seq=%s"
    curs.execute(sql, (name, phone, address, relation, seq))
    conn.commit()
    conn.close()
    return {"result" : "OK"}
  except Exception as e:
    print("Error :", e)
    return {"result" : "Error"}

@app.post("/update_with_image")
async def update_with_image(seq: int = Form(...), name: str=Form(...), phone: str=Form(...), address: str=Form(...), relation: str=Form(...), file: UploadFile = File(...)):
  try:
    image_data = await file.read()
    conn = connect()
    curs = conn.cursor()
    sql = "UPDATE address SET name = %s, phone = %s, address = %s, relation = %s, image = %s where seq=%s" # 이미지도 string타입으로 가져온다.
    curs.execute(sql, (name, phone, address, relation, image_data, seq))
    conn.commit()
    conn.close()
    return {"result" : "OK"}
  except Exception as e:
    print("Error", e)
    return {"result" : "Error"}
  


@app.delete("/delete/{seq}")
async def delete(seq: int):
  try:
    conn = connect()
    curs = conn.cursor()
    curs.execute("DELETE FROM address where seq = %s", (seq, ))
    conn.commit()
    conn.close()
    return {"result" : "OK"}
  except Exception as e:
    print("Error:", e)
    return {"result":"Error"}


# 파이썬 메인 함수
if __name__ == "__main__":
  import uvicorn
  uvicorn.run(app, host="127.0.0.1", port=8000)