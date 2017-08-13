FROM postgres:alpine
MAINTAINER Scott Willson "<scott.willson@gmail.com>"
COPY bin/create_database /docker-entrypoint-initdb.d/create_database.sh
COPY schema.sql /docker-entrypoint-initdb.d/schema
