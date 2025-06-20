from fastapi import FastAPI, HTTPException
from motor.motor_asyncio import AsyncIOMotorClient
from pydantic import BaseModel
from typing import Optional
import base64

app = FastAPI()
MONGO_URI = "mongodb://localhost:27017"
client = AsyncIOMotorClient(MONGO_URI)
db = client.lecture
collection = db.student

class Student(BaseModel):
  code : str
  name : str
  dept : str
  phone : str
  image : Optional[str] = None

class StudentUpdate(BaseModel):
  code : Optional[str] = None
  name : Optional[str] = None
  dept : Optional[str] = None
  phone : Optional[str] = None

class StudentUpdateAll(StudentUpdate): ## 상속
  image : Optional[str] = None

@app.get("/select")
async def select():
  students = await collection.find().to_list(None) ## DB에서 다 가져왔다. 그것을 리스트로 바꾸고 기본값을 None으로
  for student in students: ## 하나 읽어와서
      student["_id"] = str(student["_id"])
      if "image" in student and student["image"]: ## 키값이 있는가?
        if isinstance(student['image'], bytes): ## 실제 데이터가 있는가?
          student['image'] = base64.b64encode(student['image']).decode('utf-8') ## str를 b64로 인코딩하고, 한글 때문에 다시 utf-8로 디코딩한다.
  return {'results' : students}

@app.post("/insert")
async def insert(student: Student):
  existing_student = await collection.find_one({"code" : student.code}) ## student의 code를 찾는다.
  if existing_student: ## existing_student가 true면
    raise HTTPException(status_code=400, detail="Student is exsited")
  student_data = student.model_dump()
  if student.image:
    try:
      student_data['image'] = base64.b64decode(student.image)
    except Exception:
      raise HTTPException(status_code=400, detail="Invalid Base64 image")
  await collection.insert_one(student_data)
  return {"result" : "OK"}


@app.put("/update/{code}")
async def update(code: str, student: StudentUpdate):
  student_data = student.model_dump(exclude_unset=True) ## 안쓰는것은 제외한다.
  if not student_data:
    raise HTTPException(status_code=400, detail="No Field for update")
  update_result = await collection.update_one({"code" : code}, {"$set" : student_data})
  if update_result.matched_count == 0:
    raise HTTPException(status_code=400, detail="Student no found")
  return {"result" : "OK"}


@app.put("/updateAll/{code}")
async def updateAll(code: str, student: StudentUpdateAll):
    student_data = student.model_dump()
    if not student_data:
        raise HTTPException(status_code=400, detail="No field for update")
    
    if "image" in student_data and student_data['image']:
        try:
            student_data['image'] = base64.b64decode(student_data['image'])
        except Exception:
            raise HTTPException(status_code=400, detail="Invalid type")

    update_result = await collection.update_one({"code" : code}, {"$set" : student_data})
    if update_result.matched_count == 0:
        raise HTTPException(status_code=400, detail="Student not found")
    return {"result" : "OK"}


@app.delete("/delete/{code}")
async def updateAll(code: str):

  delete_result = await collection.delete_one({"code" : code})
  if delete_result.matched_count == 0:
    raise HTTPException(status_code=400, detail="Student no found")
  return {"result" : "OK"}


if __name__ == "__main__":
  import uvicorn
  uvicorn.run(app, host="127.0.0.1", port=8000, limit_max_requests=1024*1024*10)