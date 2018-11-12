FROM python:2.7

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update && apt-get install -qy \
  libldap2-dev \
  libsasl2-dev \
  && apt-get clean

RUN pip install --upgrade --no-cache-dir pip

RUN mkdir -p /app
WORKDIR /app

COPY ./app ./
RUN pip install -r requirements.txt
RUN pip install -r requirements-postgres.txt

# RUN python manage.py migrate --noinput
# RUN python manage.py collectstatic --noinput

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
# CMD ["gunicorn", "--bind", ":8000", "--config", "gunicorn_settings.py", "--reload", "wsgi:application"]
