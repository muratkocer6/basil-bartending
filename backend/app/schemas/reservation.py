from pydantic import BaseModel

class Reservation(BaseModel):
    name: str
    email: str
    event_date: str
    guest_count: int
    message: str
