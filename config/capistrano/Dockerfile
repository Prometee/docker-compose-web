FROM ruby:alpine

ARG CAPISTRANO_ROOT=/var/www/html
ENV CAPISTRANO_ROOT ${CAPISTRANO_ROOT}

COPY docker-capistrano-entrypoint /usr/local/bin/docker-capistrano-entrypoint

WORKDIR ${CAPISTRANO_ROOT}

RUN gem install capistrano

ENTRYPOINT ["docker-capistrano-entrypoint"]
CMD ["tail", "-f", "/dev/null"]
