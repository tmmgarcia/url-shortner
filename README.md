# url-shortner

### Getting started

You might need to login on Docker before you download an image from DockerHub

```
cp .env.sample .env &&
docker-compose pull &&
docker-compose run --rm app rake db:create &&
docker-compose run --rm app rake db:migrate &&
docker-compose up
```

```
docker-compose run --rm app rails c
```

### References

I have used the following resources to base this project's development

* https://www.railscarma.com/blog/technical-articles/simple-way-shorten-long-urls-rails/
* https://nickjanetakis.com/blog/dockerize-a-rails-5-postgres-redis-sidekiq-action-cable-app-with-docker-compose
* https://hackernoon.com/dockerizing-an-existing-rails-postgresql-app-with-docker-compose-a30a7e1b3f40
