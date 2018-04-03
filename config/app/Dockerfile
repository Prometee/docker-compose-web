ARG PHP_VERSION=7.1

FROM composer:latest
FROM php:${PHP_VERSION}-fpm-alpine

ARG APP_ROOT=/var/www/html
ENV APP_ROOT ${APP_ROOT}

RUN apk add --no-cache --virtual .persistent-deps \
		git \
		icu-libs \
		zlib

ENV APCU_VERSION 5.1.8
RUN set -xe \
	&& apk add --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		icu-dev \
		zlib-dev \
	&& docker-php-ext-install \
		intl \
		zip \
		pdo_mysql \
	&& pecl install \
		apcu-${APCU_VERSION} \
		xdebug \
	&& docker-php-ext-enable apcu \
	&& docker-php-ext-enable xdebug \
	&& apk del .build-deps

#Allow custom config available from volume mounting
#volumes:
#  - ${DOCKER_APP_CONFIG_DIR}/php:/usr/local/etc/php/conf.custom.d/
ENV PHP_INI_SCAN_DIR "/usr/local/etc/php/conf.d:/usr/local/etc/php/conf.custom.d"

COPY --from=0 /usr/bin/composer /usr/bin/composer

#Specific to symfony
RUN mkdir -p ${APP_ROOT}/var ${APP_ROOT}/var/cache/ ${APP_ROOT}/var/logs/ ${APP_ROOT}/var/sessions/ \
	&& chmod -R 777 ${APP_ROOT}/var

WORKDIR ${APP_ROOT}
