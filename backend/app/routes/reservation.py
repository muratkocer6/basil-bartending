from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.schemas.reservation import Reservation  # ← Pydantic schema
from app.models.reservation import Reservation as ReservationModel  # ← SQLAlchemy model
from app.utils.email import send_email
from app.database import get_db

router = APIRouter()

@router.post("/reservation")
def create_reservation(reservation: Reservation, db: Session = Depends(get_db)):
    db_res = ReservationModel(**reservation.dict())
    db.add(db_res)
    db.commit()
    db.refresh(db_res)

    print("📬 send_email() called")  # Debug
    send_email(reservation)

    return {"message": "Reservation saved and emailed", "id": db_res.id}

