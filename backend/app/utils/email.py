import smtplib
import os
from email.mime.text import MIMEText
from dotenv import load_dotenv

load_dotenv()
import smtplib
import os
from email.mime.text import MIMEText
from dotenv import load_dotenv

load_dotenv()  # Load environment variables from .env

def send_email(reservation_data):
    message = f"""
    New reservation received:

    Name: {reservation_data.name}
    Email: {reservation_data.email}
    Date: {reservation_data.event_date}
    Guests: {reservation_data.guest_count}
    Message: {reservation_data.message}
    """

    msg = MIMEText(message)
    msg["Subject"] = "New Reservation - Basil Bartending"
    msg["From"] = os.getenv("EMAIL_USER")
    msg["To"] = os.getenv("EMAIL_TO")

    try:
        server = smtplib.SMTP(os.getenv("EMAIL_HOST"), int(os.getenv("EMAIL_PORT")))
        server.starttls()
        server.login(os.getenv("EMAIL_USER"), os.getenv("EMAIL_PASS"))
        server.send_message(msg)
        server.quit()
        print("✅ Email sent successfully")
    except Exception as e:
        print("❌ Failed to send email:", e)
