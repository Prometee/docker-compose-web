#!/bin/sh

set -e

if [[ -z ${APP_ROOT_MULTIPLE}  ]]
then
    rm -f /usr/local/etc/php/conf.custom.d/*-a_p_t-*.ini
fi
cp -f /usr/local/etc/php/conf.project_type.d/*${APP_PROJECT_TYPE}.ini /usr/local/etc/php/conf.custom.d/

exec "$@"