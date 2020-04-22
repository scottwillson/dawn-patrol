FROM postgres:12.2-alpine
MAINTAINER Scott Willson "<scott.willson@gmail.com>"
ENV POSTGRES_HOST_AUTH_METHOD=trust
COPY bin/create_development_databases /docker-entrypoint-initdb.d/create_development_databases.sh
COPY schema.sql /docker-entrypoint-initdb.d/schema
COPY bin/shmig shmig
COPY bin/migrate migrate
COPY migrations migrations
