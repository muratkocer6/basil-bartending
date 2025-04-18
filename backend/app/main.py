from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import reservation  # Reservation router'ı dahil ediyoruz

app = FastAPI()

# CORS ayarları
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Production'da: ["https://basilbartending.com"]
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Ana endpoint
@app.get("/")
def home():
    return {"message": "Welcome to Basil Bartending API"}
@app.get("/api")
def root_check():
    return {"message": "Backend is alive!"}

# Reservation endpoint'ini dahil ediyoruz
app.include_router(reservation.router, prefix="/api")

from app.database import engine
from app.models import reservation as models

models.Base.metadata.create_all(bind=engine)
