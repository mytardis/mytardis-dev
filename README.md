# mytardis-dev
Run MyTardis for development in Docker.

Get MyTardis up and running at http://localhost/:
```
git clone git@github.com:dyakhnov/mytardis-dev.git
git clone git@github.com:mytardis/mytardis.git app
git clone git@github.com:wettenhj/mytardis-app-mydata.git app/tardis/apps/mydata
docker-compose up -d
```

Create database and admin user:
```
docker-compose exec django python manage.py migrate
docker-compose exec django python manage.py createsuperuser
docker-compose exec django python mytardis.py migrate mydata
docker-compose exec django python mytardis.py loaddata tardis/apps/mydata/fixtures/default_experiment_schema.json
```

Once you are done:
```
docker-compose down
```
