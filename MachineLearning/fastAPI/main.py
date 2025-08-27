# main.py

from fastapi import FastAPI, Request, Form
from fastapi.responses import HTMLResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
import pandas as pd
import folium
import os
import uvicorn  # ✅ 중요!

app = FastAPI()

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
app.mount("/static", StaticFiles(directory=os.path.join(BASE_DIR, "static")), name="static")
templates = Jinja2Templates(directory=os.path.join(BASE_DIR, "templates"))

@app.get("/", response_class=HTMLResponse)
async def read_form(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

@app.post("/map", response_class=HTMLResponse)
async def generate_map(request: Request, date: str = Form(...)):
    summary = pd.read_csv("data/summary_2023.csv")
    station = pd.read_csv("data/따릉이_성동구_대여소.csv")[['대여소_ID', '주소1', '위도', '경도']]
    filtered = summary[summary['기준_날짜'] == date]
    merged = pd.merge(
    filtered,
    station[['대여소_ID', '주소1', '위도', '경도']],
    left_on='대여소ID',
    right_on='대여소_ID',
    how='left'
)
    merged = merged.dropna(subset=['위도', '경도'])
    m = folium.Map(location=[37.55, 127.04], zoom_start=14)
    for _, row in merged.iterrows():
        popup = folium.Popup(f"""
            <div style="font-size:14px; max-width:300px">
              <b>대여소 ID:</b> {row['대여소ID']}<br>
              <b>주소:</b> {row['주소1']}<br>
              <b>대여건수:</b> {row['대여건수']}<br>
              <b>반납건수:</b> {row['반납건수']}<br>
              <b>반납-대여:</b> {row['반납-대여']}
            </div>
        """, max_width=300)

        color = 'blue' if row['반납-대여'] >= 0 else 'red'
        folium.Marker([row['위도'], row['경도']], popup=popup, icon=folium.Icon(color=color)).add_to(m)

    map_path = os.path.join(BASE_DIR, "static/성동구_지도.html")
    m.save(map_path)

    return templates.TemplateResponse("map.html", {"request": request, "map_url": "/static/성동구_지도.html"})


# ✅ main 함수 추가
if __name__ == "__main__":
    uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)