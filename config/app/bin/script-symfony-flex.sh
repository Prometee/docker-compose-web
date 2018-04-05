#!/bin/sh

set -e

[ ! -d ${APP_ROOT}/${APP_CACHE_DIR} ] && mkdir -p ${APP_ROOT}/${APP_CACHE_DIR}
[ ! -d ${APP_ROOT}/${APP_LOGS_DIR} ] && mkdir -p ${APP_ROOT}/${APP_LOGS_DIR}
[ ! -d ${APP_ROOT}/${APP_SESSIONS_DIR} ] && mkdir -p ${APP_ROOT}/${APP_SESSIONS_DIR}

chmod 777 \
    ${APP_ROOT}/${APP_CACHE_DIR} \
    ${APP_ROOT}/${APP_LOGS_DIR} \
    ${APP_ROOT}/${APP_SESSIONS_DIR}/

exec "$@"