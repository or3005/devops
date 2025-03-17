# השתמש בתמונה בסיסית
FROM python:3.9-slim

# עדכן את מערכת הקבצים
RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

# העתק את קבצי הקוד שלך לתוך הקונטיינר
COPY . /app

# הגדר את תיקיית העבודה
WORKDIR /app

# התקן את הדרישות של האפליקציה
RUN pip install -r requirements.txt

# פתח את הפורט של השרת
EXPOSE 80

# הרץ את האפליקציה
CMD ["python3", "app.py"]