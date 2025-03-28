from sqlalchemy import Column, Integer, String, Date
from app.database import Base

class Reservation(Base):
    __tablename__ = "reservations"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    email = Column(String, nullable=False)
    event_date = Column(String, nullable=False)  # Store as string for simplicity
    guest_count = Column(Integer)
    message = Column(String)
