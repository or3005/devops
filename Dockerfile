FROM python:3.9-slim AS builder

ENV AWS_ACCESS_KEY_ID=<"provided in exam">
ENV AWS_SECRET_ACCESS_KEY=<"provided in exam">

WORKDIR /app

COPY . /app

#ONE OF THIS COMMANDS WILL BE USED
RUN pip install --no-cache-dir -r requirements.txt



# stage 2
FROM python:3.9-slim

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 5001

RUN echo "Final-image stage has finished "
CMD ["python", "app.py"]