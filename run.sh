#!/bin/bash
PROJECT_NAME="example"
EXPOSE_PORT="9000"
MYSQL_ROOT_PASSWORD="root"
MYSQL_DATABASE="app"

# Run MySQL container
docker run --name $PROJECT_NAME.mysql \
 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
 -e MYSQL_DATABASE=$MYSQL_DATABASE \
 --restart=always \
 -v /var/www/$PROJECT_NAME/docker/mysql/data:/var/lib/mysql \
 -v /var/www/$PROJECT_NAME/docker/mysql/dumps:/docker-entrypoint-initdb.d \
 -d mysql

# Run Apache2/PHP container
docker run --name $PROJECT_NAME.apache2 \
 -p $EXPOSE_PORT:80 \
 --link $PROJECT_NAME.mysql:mysql \
 --link mailhog:mailhog \
 --restart=always \
 -v /var/www/$PROJECT_NAME/source:/var/www/html \
 -v /var/www/$PROJECT_NAME/shared:/var/www/shared \
 -d php7_apache