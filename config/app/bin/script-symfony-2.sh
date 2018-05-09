#!/bin/sh

set -e

[ ! -d ${APP_ROOT}/${APP_CACHE_DIR} ] && mkdir -p ${APP_ROOT}/${APP_CACHE_DIR}
[ ! -d ${APP_ROOT}/${APP_LOGS_DIR} ] && mkdir -p ${APP_ROOT}/${APP_LOGS_DIR}
[ ! -d ${APP_ROOT}/${APP_SESSIONS_DIR} ] && mkdir -p ${APP_ROOT}/${APP_SESSIONS_DIR}

chmod -R 777 \
    ${APP_ROOT}/${APP_CACHE_DIR} \
    ${APP_ROOT}/${APP_LOGS_DIR} \
    ${APP_ROOT}/${APP_SESSIONS_DIR}

if [[ -z ${APP_ROOT_MULTIPLE}  ]]
then
    rm -f /usr/local/etc/php/conf.custom.d/*-a_p_t-*.ini
fi
cp -f /usr/local/etc/php/conf.project_type.d/*${APP_PROJECT_TYPE}.ini /usr/local/etc/php/conf.custom.d/

exec "$@"
