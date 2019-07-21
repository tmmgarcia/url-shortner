# URL Shortner

This project aims to solve a very simple issue: make an url shorter.

### Getting started

##### Running Docker

You might need to login on Docker before you download an image from DockerHub.

First of all, configure `.env.sample` file according to your needs but there isn't any issue if you don't change it.
Open your shell and go to the project's root folder. Run the following command:

```
cp .env.sample .env &&
docker-compose pull &&
docker-compose run --rm app rake db:create &&
docker-compose run --rm app rake db:migrate &&
docker-compose run --rm sidekiq rake populate:available_path_list &&
docker-compose up
```

###### Debuging

If you need to debug something on the application just type:

```
docker attach url-shortner-app

###### Console

You can access the application console using:

```
docker-compose run --rm app rails c
```

##### Running Locally

Running this project locally is possible, but time-consuming when compared to Docker.
Make sure you have `Postgres:10.5` and `ruby:2.6.3` adequately installed and configured.
You might also need to import the environment variables from `.env.sample` to your project.
This [website](http://railsapps.github.io/rails-environment-variables.html) has good references about how you can do it.
When everything is configured, you can run the following command.

```
rails s
```

### Usage

1) Access main page
2) Click on `click here!` link
3) Type your url at field
4) Click on `Shorten`
5) Get the generated path
6) Click on the generated path
7) Close the new window created
8) Type on your navigation bar and paste the path copied at the step 5
9) Hit enter
10) Boom! You were redirected

### Hightlights

1) Cache System Sidekiq + Redis
2) Fully Dockerized
3) Small services with single responsability - SOLID
4) Clean Layout
5) DRY initializer usage
6) Test coverage

### Desired Improvements

1) Add a captcha verification to avoid robot attacks
2) Add a configuration to release to production
3) Add user login
4) Allow users to see a list of generated links
5) Add support to i18n

### Bugs

1) The URL form breaks when an user inserts an invalid url

### References

I have used the following resources to base this project's development

* https://www.railscarma.com/blog/technical-articles/simple-way-shorten-long-urls-rails/
* https://nickjanetakis.com/blog/dockerize-a-rails-5-postgres-redis-sidekiq-action-cable-app-with-docker-compose
* https://hackernoon.com/dockerizing-an-existing-rails-postgresql-app-with-docker-compose-a30a7e1b3f40
* https://thoughtbot.com/blog/testing-and-environment-variables
* https://stackoverflow.com/a/32968918/5171758
