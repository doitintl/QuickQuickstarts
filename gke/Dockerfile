FROM python:3.9-slim

ENV PYTHONUNBUFFERED True

ENV APP_HOME /app
WORKDIR $APP_HOME
COPY . ./

EXPOSE 8080
RUN pip install Flask==1.0.2
CMD exec python main.py
