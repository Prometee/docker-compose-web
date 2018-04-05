#!/bin/sh

set -e

if [ ! -d ${APP_ROOT}/var ]
then
    mkdir -p \
            ${APP_ROOT}/var \
            ${APP_ROOT}/var/cache/ \
            ${APP_ROOT}/var/logs/ \
            ${APP_ROOT}/var/sessions/ \
        && chmod 777 \
            ${APP_ROOT}/var \
            ${APP_ROOT}/var/cache/ \
            ${APP_ROOT}/var/logs/ \
            ${APP_ROOT}/var/sessions/
fi

exec "$@"