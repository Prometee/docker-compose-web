FROM ruby:alpine

ARG CAPISTRANO_ROOT=/var/www/html
ENV CAPISTRANO_ROOT ${CAPISTRANO_ROOT}

COPY docker-capistrano-entrypoint /usr/local/bin/docker-capistrano-entrypoint

RUN gem install capistrano \
    && gem install capistrano-composer

WORKDIR ${CAPISTRANO_ROOT}

ENTRYPOINT ["docker-capistrano-entrypoint"]
CMD ["tail", "-f", "/dev/null"]
