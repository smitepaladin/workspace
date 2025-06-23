# 여기가 핸들러
from fastapi import APIRouter

router = APIRouter()
@router.get("/")
async def read_items():
  return {"message" : "Read all product"}


@router.get("/{item_id}")
async def read_item(item_id : int):
  return {"product_id" : item_id}