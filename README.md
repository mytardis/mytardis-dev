# Run MyTardis for development in Docker

### Get MyTardis up and running at http://localhost/
```
git clone --recurse-submodules git@github.com:mytardis/mytardis-dev.git
cd mytardis-dev
docker-compose up -d
```

Because we are mapping submodules folder with running container, we have to:
```
docker-compose exec django npm install
docker-compose exec django npm run-script build
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

Only after performing all the steps above you will be able to access MyTardis at localhost.

### Testing
```
docker-compose exec django pylint --rcfile .pylintrc tardis
docker-compose exec django python test.py test --settings=tardis.test_settings
```

### Shutdown development stack
```
docker-compose down
```

If you want tear down stack completely, don't forget to remove volumes:
```
docker-compose down -v
```

To rebuild images for the stack:
```
docker-compose build
```

In case you want to cleanup Docker system completely:
```
docker system prune -a
docker volume rm $(docker volume ls -f dangling=true -q)
```

### Available services and ports
```
HAProxy          http://localhost
Nginx            http://localhost:81
Gunicorn/Django  http://localhost:8000
RabbitMQ         http://localhost:15672
Elasticsearch    http://localhost:9200
Kibana           http://localhost:5601
LDAP             localhost:389
PostgreSQL       localhost:5432
```