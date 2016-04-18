FROM nginx

MAINTAINER Andrii Valkiv "andrij2012@gmail.com"

# RUN  rm -rf /etc/nginx/conf.d/* \

RUN rm -rf /etc/nginx/sites-enabled/*

COPY ./nginx.conf /etc/nginx/nginx.conf
COPY sites-enabled/typo3_80 /etc/nginx/sites-enabled/typo3_80

VOLUME /home/andriy/www