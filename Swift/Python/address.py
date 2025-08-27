# -*- coding: utf-8 -*-
"""
author : SmitePaladin
Description : MySQL의 Python Data와 CRUD on IOS
"""

# 터미널 pip install python-multipart   
# image는 BLOB형태로 저장하는것이 아니라 varchar형태로 주소만 저장한다. BLOB로 이미지를 직접 저장하면 서버가 부담이 너무 크다.

from fastapi import FastAPI, File, UploadFile
from fastapi.responses import FileResponse
from fastapi.middleware.cors import CORSMiddleware
import pymysql
import os
import shutil

app = FastAPI()

# CORS 설정
app.add_middleware(
  CORSMiddleware,
  allow_origins=["*"],
  allow_methods=["*"],
  allow_headers=["*"]
)

UPLOAD_FOLDER = 'uploads' # 실행하면 알아서 폴더를 만들고 거기에 이미지를 저장하고 삭제한다.
if not os.path.exists(UPLOAD_FOLDER): # 폴더가 없으면
  os.makedirs(UPLOAD_FOLDER) # 만들어라

def connect():
    conn = pymysql.connect(
        host="127.0.0.1", # 밑에는 웹서버ip, 이건 DB ip, 회사꺼 써야함
        user='root', # 회사에서는 root로 못 씀
        password='qwer1234', # password도 회사에서 못 씀
        # 여기까진 mysql에 들어갈 때 적는 내용

        db='ios',
        # db 이름

        charset='utf8'
    )
    return conn
# 다른 function에서 불러서 연결

@app.post("/upload")
async def upload_file(file: UploadFile = File(...)): 
# (...)은 Python에 없음, swift 방식, file: UploadFile 같이 뒤에 타입적는 것도 swift 방식

    try:
        file_path = os.path.join(UPLOAD_FOLDER, file.filename) # 경로만든거
        # close 대신 with를 사용 with에서 빠져나올 때 close 됨
        # write binary = 메모장으로 안 보이는 본인만의 압축방식으로 만든 파일

        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer) # file.file을 복사

        return{'result':'OK'}
    except Exception as ex:
        print("Error :", ex)
        return {'result':'Error'}

@app.delete("/deleteFile/{file_name}")
async def delete_file(file_name: str):
    try:
        file_path = os.path.join(UPLOAD_FOLDER, file_name)
        if os.path.exists(file_path): # 이 경로에 file_name이 있다면
            os.remove(file_path) # 지운다
    except Exception as ex:
        print("Error :", ex)
        return{'result':'Error'}
  
@app.get("/view/{file_name}")   # GET 요청으로 /view/파일이름 에 접근하면 실행
async def get_file(file_name: str):
    file_path = os.path.join(UPLOAD_FOLDER, file_name)  # 업로드 폴더에서 해당 파일 경로 생성
    
    if os.path.exists(file_path):  # 파일이 실제 존재하는지 확인
        return FileResponse(path=file_path, filename=file_name)  # 파일을 응답으로 전송
    
    return {'result':'Error'}  # 없으면 JSON 형태로 에러 반환
  
@app.get("/select")
async def select():
  # Connection
  conn = connect()
  curs = conn.cursor()

  # SQL
  sql = "SELECT id, name, phone, address, relation, image FROM address order by name"
  curs.execute(sql) # workbench에서 sql문을 직접 쳐 넣은것과 같다.
  rows = curs.fetchall() # sql문 결과값을 rows에 넣어준다.
  conn.close() # 연결종료, 이후는 데이터베이스와 상관이 없다.
  print(rows) # 결과값 찍어주고
  dict_list = [] # 데이터값을 넣기 위한 딕셔너리를 하나 만들어준다. 현재는 데이터값만 있다. 앱에서 보여줄 때 헷갈림
  for row in rows: # row는 row한줄
    dict_list.append( # dict_list에다 넣어줄건데, 딕셔너리 모양으로
      {
        'id': row[0],
        'name': row[1],
        'phone': row[2],
        'address': row[3],
        'relation': row[4],
        'image': row[5]
      }
    )
  print(dict_list)
  return dict_list

@app.get("/insert")
async def insert(name: str=None, phone: str=None, address: str=None, relation: str=None, image: str=None):
    conn = connect()
    curs = conn.cursor()

    try:
        sql = "insert into address(name, phone, address, relation, image) values (%s, %s, %s, %s, %s)"
        
        curs.execute(sql, (name, phone, address, relation, image))
        # 실행 뿐 아니라 sql에 들어갈 값들을 넣어줘야함

        conn.commit() # MySQL은 기본적으로 auto commit이라 안 해도 되는데 서버에 따라 뺄 수도 있어서 해줌
        conn.close()
        return{'result':'OK'}

    except Exception as ex:
        conn.close()
        print("Error:", ex)
        return{"result":'Error'}

@app.get("/update") # 이미지 없이 업데이트
async def update(name: str=None, phone: str=None, address: str=None, relation: str=None, id: str=None):
    conn = connect()
    curs = conn.cursor()

    try:
        sql = "update address set name=%s, phone=%s, address=%s, relation=%s where id=%s"
        
        curs.execute(sql, (name, phone, address, relation, id))
        # 실행 뿐 아니라 sql에 들어갈 값들을 넣어줘야함

        conn.commit() # MySQL은 기본적으로 auto commit이라 안 해도 되는데 서버에 따라 뺄 수도 있어서 해줌
        conn.close()
        return{'result':'OK'}

    except Exception as ex:
        conn.close()
        print("Error:", ex)
        return{"result":'Error'}


@app.get("/updateAll") # 이미지 포함하여 업데이트
async def update(name: str=None, phone: str=None, address: str=None, relation: str=None, image: str=None, id: str=None):
# 위의 update와 이름이 같지만 매개변수 개수가 다르므로 오버로드
    conn = connect()
    curs = conn.cursor()

    try:
        sql = "update address set name=%s, phone=%s, address=%s, relation=%s, image=%s where id=%s"
        
        curs.execute(sql, (name, phone, address, relation, image, id))
        # 실행 뿐 아니라 sql에 들어갈 값들을 넣어줘야함

        conn.commit() # MySQL은 기본적으로 auto commit이라 안 해도 되는데 서버에 따라 뺄 수도 있어서 해줌
        conn.close()
        return{'result':'OK'}

    except Exception as ex:
        conn.close()
        print("Error:", ex)
        return{"result":'Error'}
    
@app.get("/delete")
async def delete(id: str=None):
    conn = connect()
    curs = conn.cursor()

    try:
        sql = "delete from address where id = %s"
        
        curs.execute(sql, (id))
        # 실행 뿐 아니라 sql에 들어갈 값들을 넣어줘야함

        conn.commit() # MySQL은 기본적으로 auto commit이라 안 해도 되는데 서버에 따라 뺄 수도 있어서 해줌
        conn.close()
        return{'result':'OK'}

    except Exception as ex:
        conn.close()
        print("Error:", ex)
        return{"result":'Error'}

if __name__ == "__main__":
  import uvicorn
  uvicorn.run(app, host="127.0.0.1", port=8000)