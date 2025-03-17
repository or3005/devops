FROM python:3.9-slim AS builder

# כאן אני מעביר את המפתחות מהקובץ .env שלא יישלחו ל-repository
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

WORKDIR /app

# מעתיק את כל הקבצים לתוך התיקייה /app
COPY . /app

# התקנת הדרישות (requirements)
RUN pip install --no-cache-dir -r requirements.txt


# stage 2
FROM python:3.9-slim

WORKDIR /app

# מעתיק את כל הקבצים מהתיקייה /app בשלב builder (כולל app.py)
COPY --from=builder /app /app

EXPOSE 5001

RUN echo "Final-image stage has finished"

# תיקון הנתיב בקובץ ה- CMD כדי למצוא את app.py בצורה נכונה
CMD ["python", "/app/app.py"]
