from fastapi import FastAPI
from items import router as items_router
from product import router as product_router

app=FastAPI()
app.include_router(items_router, prefix="/items", tags=['items'])
app.include_router(product_router, prefix="/product", tags=['product'])

if __name__=="__main__":
  import uvicorn
  uvicorn.run(app, host="127.0.0.1", port=8000)