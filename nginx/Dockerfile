FROM nginx

MAINTAINER Andrii Valkiv "andrij2012@gmail.com"

# RUN  rm -rf /etc/nginx/conf.d/* \

RUN rm -rf /etc/nginx/sites-enabled/*

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./sites-enabled /etc/nginx/sites-enabled