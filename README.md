Docker Compose for WEB development
==================================

# Quick start
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
docker-compose build
```

# Configuration by `${PROJECT_TYPE}`
## `"symfony-flex"`

This configuration has a specific php configuration and a vhost file. Plus, you can keep `/var/*` folders in the
container to avoid some performances issues on Windows for exemple. If you want to use it go to the
`docker-compose.yaml` file and add or uncomment thoses lines :
```yaml
  app:
    volumes:
      # BEGIN symfony-flex
      - ${APP_ROOT}/var/
      - ${APP_ROOT}/var/cache/
      - ${APP_ROOT}/var/logs/
      - ${APP_ROOT}/var/sessions/
      # END symfony-flex
```

## `"symfony-1"`
@TODO
## `"symfony-2"`
@TODO
## `"drupal"`
@TODO
## `"wordpress"`
@TODO

#Addons

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
docker-compose -f ./docker-compose.capistrano.yaml exec capistrano cap deploy stagging
```
or run it
```cmd
docker-compose -f ./docker-compose.capistrano.yaml run capistrano cap deploy stagging
```

## Node

@TODO