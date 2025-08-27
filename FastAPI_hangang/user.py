"""
author : smitepaladin 전종익
description : Firebase Authentication를 이용한 한강 프로젝트 회원가입, 로그인
date : 2025.08.19
version : 1.0

추가된 firebase_key.json는 firebase키 입니다. 안에 개인 키내용은 귀찮아서 그냥 넣어놨습니다. 

 * 2025 8월 19일
 * 개발일지 : 가입, 로그인시 firebase 인증
 * 개발자 : 전종익
 */

"""


from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import os
import firebase_admin
from firebase_admin import credentials, auth as fb_auth

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
KEY_PATH  = os.path.join(BASE_DIR, "firebase_key.json")

# Firebase Admin 초기화 (중복 방지)
if not firebase_admin._apps:
    cred = credentials.Certificate(KEY_PATH)
    firebase_admin.initialize_app(cred)

router = APIRouter()

class VerifyReq(BaseModel):
    idToken: str

@router.post("/verify")
async def verify(req: VerifyReq):
    try:
        decoded = fb_auth.verify_id_token(req.idToken)
        return {
            "result": "ok",
            "uid": decoded.get("uid"),
            "email": decoded.get("email"),
            "claims": decoded.get("claims") or {}
        }
    except fb_auth.ExpiredIdTokenError:
        raise HTTPException(status_code=401, detail="idToken 만료")
    except fb_auth.InvalidIdTokenError:
        raise HTTPException(status_code=401, detail="유효하지 않은 idToken")
    except Exception as e:
        raise HTTPException(status_code=400, detail=f"검증 실패: {e}")