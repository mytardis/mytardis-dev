FROM python:3.6

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

RUN pip install --upgrade pip


# Create runtime user
RUN mkdir -p /app && \
    groupadd -r -g 1001 mytardis && \
    useradd -r -m -u 1001 -g 1001 mytardis

WORKDIR /app

COPY submodules/mytardis/ ./
COPY submodules/mytardis-app-mydata/ tardis/apps/mydata/
COPY settings.py tardis/

# don't install Git repos in 'edit' mode
RUN sed -i 's/-e git+/git+/g' requirements-base.txt

RUN pip install -r requirements.txt
RUN pip install -r requirements-postgres.txt
RUN pip install -r tardis/apps/mydata/requirements.txt

RUN npm install -g
RUN npm run-script build

RUN chown -R mytardis:mytardis /app
USER mytardis
EXPOSE 8000

# RUN python manage.py migrate --noinput
# RUN python manage.py collectstatic --noinput

CMD ["gunicorn", "--bind", ":8000", "--workers", "1", "--worker-class", "gevent", "--reload", "--log-level", "DEBUG", "wsgi:application"]
