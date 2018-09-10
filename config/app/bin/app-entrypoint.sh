#!/bin/sh

set -e

ln -sf /usr/local/etc/php/conf.d/zz99-project_type.ini /usr/local/etc/php/conf.project_type.d/*${APP_PROJECT_TYPE}.ini

APP_ENTRYPOINT_PROJECT_TYPE="$(dirname $0)/script-${APP_PROJECT_TYPE}.sh"
if [ -x "${APP_ENTRYPOINT_PROJECT_TYPE}" ]
then
    ${APP_ENTRYPOINT_PROJECT_TYPE}
fi

exec "$@"