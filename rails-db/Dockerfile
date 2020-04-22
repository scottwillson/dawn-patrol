FROM mysql:5.6.47

ENV MYSQL_DATABASE cbra
ENV MYSQL_USER cbra
ENV MYSQL_PASSWORD rails
ENV MYSQL_RANDOM_ROOT_PASSWORD yes

VOLUME /var/lib/mysql

COPY dawn-patrol.cnf /etc/mysql/conf.d
COPY schema.sql /docker-entrypoint-initdb.d/_schema.sql
COPY atra.sql /docker-entrypoint-initdb.d
COPY cbra.sql /docker-entrypoint-initdb.d
COPY wsba.sql /docker-entrypoint-initdb.d
