FROM python:2.7

ENV PYTHONUNBUFFERED 1
ENV PYTHONDONTWRITEBYTECODE 1

RUN apt-get update && apt-get install -qy \
		gnupg \
		libldap2-dev \
		libsasl2-dev \
		libssl-dev \
		libxml2-dev \
		libxslt1-dev \
		libmagic-dev \
		libmagickwand-dev \
	&& apt-get clean

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update && apt-get install -qy \
		nodejs \
	&& apt-get clean

RUN pip install --upgrade --no-cache-dir pip

RUN mkdir -p /app
WORKDIR /app

COPY ./app ./
COPY ./settings.py ./tardis

# don't install Git repos in 'edit' mode
RUN sed -i 's/-e git+/git+/g' requirements-base.txt

RUN pip install -r requirements.txt
RUN pip install -r requirements-postgres.txt
RUN pip install -r tardis/apps/mydata/requirements.txt

RUN npm install
RUN npm run-script build

# RUN python manage.py migrate --noinput
# RUN python manage.py collectstatic --noinput

# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
CMD ["gunicorn", "--bind", ":8000", "--config", "gunicorn_settings.py", "--reload", "wsgi:application"]
