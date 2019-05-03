FROM python:3.7-alpine as base
FROM base as builder
MAINTAINER Lucas Messenger
RUN apk update && apk add --no-cache libpq postgresql-dev gcc musl-dev

COPY requirements.txt .
RUN pip3 install -r requirements.txt

FROM base
COPY --from=builder /usr/local /usr/local
COPY --from=builder /usr/lib /usr/lib
COPY src/ /app
WORKDIR /app

EXPOSE 8080
CMD ["python3", "go.py"]
