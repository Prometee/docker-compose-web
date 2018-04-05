#!/bin/sh

set -e

if [ ! -d ${APP_ROOT}/var ]
then
    mkdir -p \
            ${APP_ROOT}/app/cache/ \
            ${APP_ROOT}/app/logs/ \
            ${APP_ROOT}/app/sessions/ \
        && chmod 777 \
            ${APP_ROOT}/app/cache/ \
            ${APP_ROOT}/app/logs/ \
            ${APP_ROOT}/app/sessions/
fi

exec "$@"