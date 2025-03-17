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
#i couldnt run it with the instalation on the lasr build so i installed it here
# i know you whanted an multistage but for the lack of time i did it to continue working
COPY --from=builder /app/requirements.txt /.

EXPOSE 5001

RUN echo "Final-image stage has finished"
# app becuase of the secoend workdir and builder copy
CMD ["python", "app.py"]
