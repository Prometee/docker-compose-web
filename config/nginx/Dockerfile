FROM nginx:alpine

ARG NGINX_ROOT=/var/www/html
ENV NGINX_ROOT ${NGINX_ROOT}

#right place and security just in case you want to use this script in an prod env
ADD ssl/certs/server.crt /etc/ssl/certs/server-localhost.crt
ADD ssl/private/server.key /etc/ssl/private/server-localhost.key
RUN chmod 0600 /etc/ssl/certs/server-localhost.crt

COPY conf.d/default.conf.tpl /etc/nginx/conf.d/default.conf.tpl
COPY docker-nginx-entrypoint /usr/local/bin/docker-nginx-entrypoint

WORKDIR ${NGINX_ROOT}
ENTRYPOINT ["docker-nginx-entrypoint"]
CMD ["nginx", "-g", "daemon off;"]
