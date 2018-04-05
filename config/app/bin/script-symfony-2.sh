#!/bin/sh

set -e

[ ! -d ${APP_CACHE_DIR} ] && mkdir -p ${APP_CACHE_DIR}
[ ! -d ${APP_LOGS_DIR} ] && mkdir -p ${APP_LOGS_DIR}
[ ! -d ${APP_SESSIONS_DIR} ] && mkdir -p ${APP_SESSIONS_DIR}

chmod 777 \
    ${APP_CACHE_DIR}/ \
    ${APP_LOGS_DIR}/ \
    ${APP_SESSIONS_DIR}/

exec "$@"