# mytardis-dev
Run MyTardis for development in Docker.

Get MyTardis up and running at http://localhost/:
```
git clone git@github.com:dyakhnov/mytardis-dev.git

cd mytardis-dev

git clone git@github.com:mytardis/mytardis.git app
git clone git@github.com:mytardis/mytardis-app-mydata.git app/tardis/apps/mydata

docker-compose up -d
```

Create database and admin user:
```
docker-compose exec django python manage.py migrate
docker-compose exec django python manage.py createcachetable default_cache
docker-compose exec django python manage.py createcachetable celery_lock_cache
docker-compose exec django python manage.py collectstatic
docker-compose exec django python manage.py createsuperuser
```

Install MyData app:
```
docker-compose exec django python mytardis.py migrate mydata
docker-compose exec django python mytardis.py loaddata tardis/apps/mydata/fixtures/default_experiment_schema.json
```

Once you are done:
```
docker-compose down
```

Don't forget to remove volumes (if you want tear down stack completely):
```
docker-compose down -v
```

To rebuild images for the stack:
```
docker-compose build
```

In case you want to fully cleanup Docker system:
```
docker system prune -a
docker volume rm $(docker volume ls -f dangling=true -q)
```
