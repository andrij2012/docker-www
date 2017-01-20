#!/bin/bash
PROJECT_NAME="example"
EXPOSE_PORT="80"
MYSQL_ROOT_PASSWORD="root"
MYSQL_DATABASE="app"

# Run MySQL container
docker run --name mysql.$PROJECT_NAME \
 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
 -e MYSQL_DATABASE=$MYSQL_DATABASE \
 --restart=always \
 -v /var/www/$PROJECT_NAME/docker/mysql/data:/var/lib/mysql \
 -v /var/www/$PROJECT_NAME/docker/mysql/dumps:/docker-entrypoint-initdb.d \
 -d mysql \
 --sql-mode="" \
 --character-set-server=utf8 \
 --collation-server=utf8_general_ci

# Run Apache2/PHP container
docker run --name apache2.$PROJECT_NAME \
 -p $EXPOSE_PORT:80 \
 --link mysql.$PROJECT_NAME:mysql \
 --link mailhog:mailhog \
 -v /var/www/$PROJECT_NAME/source:/var/www/html \
 -v /var/www/$PROJECT_NAME/shared:/var/www/shared \
 -v /var/www/$PROJECT_NAME/docker/apache2/logs:/var/log/apache2 \
 -d php7_apache
