FROM mysql:5.6.37

ENV MYSQL_DATABASE rails
ENV MYSQL_USER rails
ENV MYSQL_PASSWORD rails
ENV MYSQL_RANDOM_ROOT_PASSWORD yes

COPY dawn-patrol.cnf /etc/mysql/conf.d
COPY schema.sql /docker-entrypoint-initdb.d/_schema.sql
COPY data.sql /docker-entrypoint-initdb.d
