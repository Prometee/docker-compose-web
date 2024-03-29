[![Build Status](https://travis-ci.org/Prometee/docker-compose-web.svg?branch=master)](https://travis-ci.org/Prometee/docker-compose-web)

Docker Compose for WEB development 
==================================

This docker-compose use php-fpm, nginx (HTTP+HTTPS/2), MySQL and Mailhog.

# Quick start

Put this repository files in a `.docker` folder in/outside your project or put it a the root of it (default behaviour)
 
```cmd
cp .env.dist .env
docker-compose up -d --build
```

 * PHP :
    * [php://localhost:9000](php://localhost:9000) or [php://127.0.0.1:9000](php://127.0.0.1:9000)
 * Web server :
    * [https://localhost](https://localhost) or [https://127.0.0.1](https://127.0.0.1)
    * [http://localhost](http://localhost) or [http://127.0.0.1](http://127.0.0.1)
 * Mailhog :
   * [http://localhost:8025](http://localhost:8025) or [http://127.0.0.1:8025](http://127.0.0.1:8025)
   * [smtp://localhost:1025](smtp://localhost:1025) or [smtp://127.0.0.1:1025](smtp://127.0.0.1:1025)
 * MySQL :
   * [mysql://localhost:3306](mysql://localhost:3306) or [mysql://127.0.0.1:3306](mysql://127.0.0.1:3306)

# Detailed using

## Initialisation

Put this repository files in a `.docker` folder in/outside your project or put it a the root of it (default behaviour)

## Environment vars

The first thing to do is to copy the `.env.dist` file to a `.env` file, then fill in the value you want to be changed.

```cmd
cp .env.dist .env
```

Change the values in `.env` following the instructions in it

## Build containers

The build process will first build nginx and add the necessary vhost, build composer+php-fpm together building and
adding necessary php-extensions with configurations (with specific configuration by PROJECT_TYPE)

```cmd
docker-compose build
```

## Starting containers
All containers will be launch and ports will be available on loopback network

```cmd
docker-compose up -d
```

# Configuration by `${PROJECT_TYPE}`

## `"symfony-flex"`

This configuration has a specific php configuration and a vhost file. Plus, you can keep `/var/*` folders in the
container to avoid some performances issues on Windows for exemple. If you want to use use this environement vars :
```cmd
PROJECT_TYPE=symfony-flex
# If you want to add other php extensions, uncomment the line bellow
# multiple extensions should be seperated by a space
# APP_PHP_EXTRA_EXTENSIONS=exif

```

## `"symfony-1"`

@TODO

## `"symfony-2"`

This configuration has a specific php configuration and a vhost file. Plus, you can keep `/app/*` folders in the
container to avoid some performances issues on Windows for example. If you want to use use this environment vars :
```cmd
PROJECT_TYPE=symfony-2
NGINX_WEB_INDEX_FILE=app_dev.php
# If you want to add other php extensions, uncomment the line bellow
# multiple extensions should be seperated by a space
# APP_PHP_EXTRA_EXTENSIONS=exif
```

## `"drupal"`

@TODO

## `"wordpress"`

This configuration has a specific php configuration and a vhost file. If you want to use use this environment vars :
```cmd
PROJECT_TYPE=wordpress
NGINX_WEB_FOLDER=
# If you want to add other php extensions, uncomment the line bellow
# multiple extensions should be seperated by a space
# APP_PHP_EXTRA_EXTENSIONS=exif
```

# Certificate trusted on MACOSX

```bash
docker-compose -f ./.docker/docker-compose.yaml -f ./.docker/docker-compose.capistrano.yaml --env-file .env \
  cp nginx:/etc/ssl/certs/server-localhost.crt .docker/config/nginx/ssl/certs/server.crt
sudo security add-trusted-cert -d -r trustRoot ./.docker/config/nginx/ssl/certs/server.crt
```

# Addons

## Capistrano

Build it like this, your private ssh key have to in your `~/.ssh` directory (or define an other ssh
key directory to use) :

```cmd
docker-compose -f ./docker-compose.capistrano.yaml build
```

**Rq:** `bundle install` is made on first `up` or every `run` if and only if a Gemfile is present at the root
of `${PROJECT_DIR}`

`up` and `exe` it (if you want to `exec` it many time this is better than only `run`) :

```cmd
docker-compose -f ./docker-compose.capistrano.yaml up -d
docker-compose -f ./docker-compose.capistrano.yaml exec capistrano cap stagging deploy
```
or run it
```cmd
docker-compose -f ./docker-compose.capistrano.yaml run capistrano cap stagging deploy
```

## NodeJS

@TODO
