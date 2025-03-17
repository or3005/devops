FROM python:3.9-slim AS builder

# here i pass the secret keys from .env file that will not be pushed to the repository
ENV AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
ENV AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

WORKDIR /app

COPY . /app

#ONE OF THIS COMMANDS WILL BE USED
RUN pip install --no-cache-dir -r requirements.txt



# stage 2
FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /app /app
RUN pip install --no-cache-dir -r requirements.txt
EXPOSE 5001

RUN echo "Final-image stage has finished "
CMD ["python", "app.py"]
