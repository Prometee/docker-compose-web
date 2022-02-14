FROM nginx:alpine

ARG NGINX_ROOT=/var/www/html
ENV NGINX_ROOT ${NGINX_ROOT}
ARG NGINX_PROJECT_TYPE=symfony-flex
ENV NGINX_PROJECT_TYPE ${NGINX_PROJECT_TYPE}

#right place and security just in case you want to use this script in an prod env
COPY ssl/certs/server.crt /etc/ssl/certs/server-localhost.crt
COPY ssl/private/server.key /etc/ssl/private/server-localhost.key
RUN if [ ! -s /etc/ssl/private/server-localhost.key ]; then \
        apk add openssl \
          && openssl req -x509 -nodes -days 36500 \
            -subj "/C=FR/O=Localhost/CN=localhost" \
            -addext "subjectAltName=DNS:localhost" \
            -newkey rsa:2048 \
            -keyout /etc/ssl/private/server-localhost.key \
            -out /etc/ssl/certs/server-localhost.crt;\
    fi
RUN chmod 0600 /etc/ssl/certs/server-localhost.crt

COPY tpl /etc/nginx/tpl
COPY docker-nginx-entrypoint /usr/local/bin/docker-nginx-entrypoint

WORKDIR ${NGINX_ROOT}
ENTRYPOINT ["docker-nginx-entrypoint"]
CMD ["nginx", "-g", "daemon off;"]
