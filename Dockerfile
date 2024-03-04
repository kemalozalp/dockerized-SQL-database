FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=root

COPY ./create_tables.sql /docker-entrypoint-initdb.d/