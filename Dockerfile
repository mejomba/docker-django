FROM python:3.9-alpine3.18
LABEL maintainer="mojtaba aminzadeh"
ENV PYTHONUNBUFFERED=1

COPY ./requirements.txt /requirements.txt
COPY . /app

WORKDIR /app

EXPOSE 8000

RUN python -m venv /venv && \
    /venv/bin/pip install --upgrade pip && \
    apk add --update --no-cache postgresql-client && \
    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev && \
    /venv/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app

ENV PATH="/venv/bin:$PATH"
USER app