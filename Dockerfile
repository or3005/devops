FROM python:3.9-slim AS builder

# here i pass the secret keys from .env file that will not be pushed to the repository
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

WORKDIR /app

COPY . /app

#ONE OF THIS COMMANDS WILL BE USED



# stage 2
FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5001


RUN echo "Final-image stage has finished "
CMD ["python", "app.py"]
