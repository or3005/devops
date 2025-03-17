FROM python:3.9-slim AS builder

# the secrets from token in git hub serets
ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY

WORKDIR /app

COPY . /app
RUN pip install --no-cache-dir -r requirements.txt
# stage 2
FROM python:3.9-slim

WORKDIR /app
# i aded problems with install os and boto3
COPY --from=builder /app/requirements.txt /.

EXPOSE 5001

RUN echo "Final-image stage has finished"
# i have problme the html is not working but i can see it on terminal i will add screenshots
CMD ["python", "app.py"]
