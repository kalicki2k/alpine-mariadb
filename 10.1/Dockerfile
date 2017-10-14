FROM kalicki2k/alpine-base:latest

MAINTAINER Sebastian Kalicki (https://github.com/kalicki2k)

COPY Dockerfiles/. /

RUN apk update && apk upgrade && \
    apk add mariadb mariadb-client && \
    chmod +x /run.sh && \
    rm -rf /var/cache/apk/*

EXPOSE 3306

ENTRYPOINT ["/run.sh"]