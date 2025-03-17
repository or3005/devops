FROM python:3.9-slim AS builder

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y npm

RUN pip install --no-cache-dir -r requirements.txt



# stage 2
FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 5001

RUN echo "Final-image stage has finished "
CMD ["python", "app.py"]