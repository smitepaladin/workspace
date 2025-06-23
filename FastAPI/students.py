"""
author      : Kenny
Description : MySQL의 python Database와 CRUD on Web
http://127.0.0.1:8000/iris?sepalLength=...&...
"""

from fastapi import FastAPI
import joblib
import pymysql
# import json

app = FastAPI()

def connect():
    # MySQL Connection
    conn = pymysql.connect(
        host='127.0.0.1',
        user='root',
        password='qwer1234',
        db='education',
        charset='utf8'
    )
    return conn


@app.get("/select")
async def select():
    # Connection으로 부터 Cursor 생성
    conn = connect()
    curs = conn.cursor()

    # SQL 문장
    sql = "SELECT * FROM student"
    curs.execute(sql)
    rows = curs.fetchall()
    conn.close()
    print(rows)

    return {'results': rows} 

@app.get("/insert")
async def insert(code: str=None, name: str=None, dept: str=None, phone: str=None, address: str=None):
    # Connection으로 부터 Cursor 생성
    conn = connect()
    curs = conn.cursor()

    # SQL 문장
    try:
        sql = "insert into student(scode, sname, sdept, sphone, saddress) values (%s,%s,%s,%s,%s)"
        curs.execute(sql, (code, name, dept, phone, address))
        conn.commit()
        conn.close()
        return {'result':'OK'}
    except Exception as ex:
        conn.close()
        print("Error :", ex)
        return {'result':'Error'}
    

@app.get("/update")
async def update(code: str=None, name: str=None, dept: str=None, phone: str=None, address: str=None):
    # Connection으로 부터 Cursor 생성
    conn = connect()
    curs = conn.cursor()

    # SQL 문장
    try:
        sql = "update student set sname=%s, sdept=%s, sphone=%s, saddress=%s where scode=%s"
        curs.execute(sql, (name, dept, phone, address, code))
        conn.commit()
        conn.close()
        return {'result':'OK'}  
    except Exception as ex:
        conn.close()
        print("Error :", ex)
        return {'result':'Error'}

@app.get("/delete")
async def delete(code: str=None):
    # Connection으로 부터 Cursor 생성
    conn = connect()
    curs = conn.cursor()

    # SQL 문장
    try:
        sql = "delete from student where scode = %s"
        curs.execute(sql, (code))
        conn.commit()
        conn.close()
        return {'result':'OK'}
    except Exception as ex:
        conn.close()
        print("Error :", ex)
        return {'result':'Error'}

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="127.0.0.1", port=8000)

# uvicorn students:app —reload



# """
# author:smitepaladin
# description:lecture
# date:2025/05/15
# version:1.0
# """

# from fastapi import FastAPI
# from pydantic import BaseModel # 클래스를 만들 수 있다.
# import pymysql

# app = FastAPI()

# class Student(BaseModel): # 이 모양으로 데이터를 받아서 쓸 수 있다. url이 감춰지는 post방식
#   code: str
#   name: str
#   dept : str
#   phone : str
#   address : str


# class StudentCode(BaseModel): # 삭제를 위한 class
#   code : str


# def connect(): # 데이터베이스에 연결
#   conn = pymysql.connect(
#     host="127.0.0.1",
#     user="root",
#     password="qwer1234",
#     db="education",
#     charset="utf8"
#   )
#   return conn

# @app.get("/select") # url에 적히는 부분, 데이터베이스 받아서 넘겨주면 된다
# async def select():
#   # Connection부터 해줘야한다.
#   conn = connect()
#   # 데이터를 실행하려면 커서가 무조건 필요하다.
#   curs = conn.cursor()

#   # SQL문장
#   sql = "SELECT * FROM student"
#   # 커서를 통해 실행
#   curs.execute(sql)
#   rows = curs.fetchall() # 결과를 받아서 넣어준다.
#   conn.close() # 데이터베이스랑 연결 끊기
#   # return rows # 이대로 주면 프론트가 고생한다.

#   # 결과값을 Dictionary로 변환
#   result = [{'code':row[0], 'name':row[1], 'dept':row[2], 'phone':row[3], 'address': "" if row[4] == None else row[4]}for row in rows]
#   return {'results' : result}

# ##### 여기까지 select

# @app.post("/insert")
# async def insert(student: Student):
#   # Connction
#   conn = connect()
#   curs = conn.cursor()


#   # SQL
#   try:
#     sql = "INSERT INTO student(scode, sname, sdept, sphone, saddress) values (%s,%s,%s,%s,%s)"
#     ## 
#     curs.execute(sql, (student.code, student.name, student.dept, student.phone, student.address))
#     conn.commit()
#     conn.close()
#     return {'result' : 'OK'}
#   except Exception as ex:
#     conn.close()
#     print("Error :", ex)
#     return {'result' : 'Error'}
  
# ##### 여기까지 insert

# @app.post("/update")
# async def update(student: Student):
#   # Connction
#   conn = connect()
#   curs = conn.cursor()


#   # SQL
#   try:
#     sql = "UPDATE student SET sname = %s, sdept = %s, sphone = %s, saddress = %s WHERE scode = %s"
#     curs.execute(sql, (student.name, student.dept, student.phone, student.address, student.code))
#     conn.commit()
#     conn.close()
#     return {'result' : 'OK'}
#   except Exception as ex:
#     conn.close()
#     print("Error :", ex)
#     return {'result' : 'Error'}
  

#   ##### 여기까지 update


# @app.post("/delete")
# async def update(studentCode: StudentCode):
#   # Connction
#   conn = connect()
#   curs = conn.cursor()


#   # SQL
#   try:
#     sql = "DELETE from student where scode = %s"
#     curs.execute(sql, (studentCode.code))
#     conn.commit()
#     conn.close()
#     return {'result' : 'OK'}
#   except Exception as ex:
#     conn.close()
#     print("Error :", ex)
#     return {'result' : 'Error'}

# ## 여기까지 delete


# if __name__=="__main__":
#   import uvicorn
#   uvicorn.run(app, host="127.0.0.1", port=8000)

# -*- coding: utf-8 -*-