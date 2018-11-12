# mytardis-dev
Run MyTardis for development in Docker.

Get MyTardis up and running at http://localhost/:
```
git clone git@github.com:dyakhnov/mytardis-dev.git
git clone git@github.com:dyakhnov/mytardis.git app
docker-compose up -d
docker-compose exec django python manage.py migrate
docker-compose exec django python manage.py createsuperuser
```

Once you are done:
```
docker-compose down
```
