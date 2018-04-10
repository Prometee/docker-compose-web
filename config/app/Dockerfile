ARG PHP_VERSION=7.1

FROM composer:latest
FROM php:${PHP_VERSION}-fpm-alpine

ARG APP_ROOT=/var/www/html
ENV APP_ROOT ${APP_ROOT}

RUN apk add --update --no-cache --virtual .persistent-deps \
		git \
		icu-libs \
		zlib
#$PHP_VERSION come from the env var of the parent image
RUN set -xe \
    APCU_PACKAGE=apcu; \
    XDEBUG_PACKAGE=xdebug; \
    if [ ${PHP_VERSION:0:3} == 5.6 ]; then \
        APCU_PACKAGE=apcu-4.0.11; \
        XDEBUG_PACKAGE=xdebug-2.5.5; \
    fi; \
	apk add --update --no-cache --virtual .build-deps \
		$PHPIZE_DEPS \
		icu-dev \
		zlib-dev \
		freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
    && docker-php-ext-configure \
        gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install \
		-j"$(getconf _NPROCESSORS_ONLN)" gd \
	&& docker-php-ext-install \
		intl \
		zip \
		pdo_mysql \
	&& pecl install \
		${APCU_PACKAGE} \
		${XDEBUG_PACKAGE} \
	&& docker-php-ext-enable apcu \
	&& docker-php-ext-enable xdebug \
	&& apk del .build-deps

#Allow custom config available from volume mounting
#volumes:
#  - ${DOCKER_APP_CONFIG_DIR}/php:/usr/local/etc/php/conf.custom.d/
ENV PHP_INI_SCAN_DIR "/usr/local/etc/php/conf.d:/usr/local/etc/php/conf.custom.d"

COPY php/conf.d/*.ini /usr/local/etc/php/conf.d/
RUN mkdir /usr/local/etc/php/conf.project_type.d/
COPY php/project_type/*.ini /usr/local/etc/php/conf.project_type.d/
COPY bin/script-*.sh /usr/local/bin/

COPY --from=0 /usr/bin/composer /usr/bin/composer

WORKDIR ${APP_ROOT}
