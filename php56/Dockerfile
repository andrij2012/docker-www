FROM php:5.6-fpm
RUN apt-get update && apt-get install -y apt-utils wget curl libfreetype6-dev libjpeg62-turbo-dev \
                                         libmcrypt-dev libpng12-dev libxml2-dev git vim \
                                         libgraphicsmagick1-dev libmagickwand-dev --no-install-recommends imagemagick graphicsmagick \
 && rm -r /var/lib/apt/lists/* \
 && docker-php-ext-install -j$(nproc) mcrypt soap xml zip mysqli json \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd \
 && pecl install xdebug \
 && docker-php-ext-enable xdebug \
 && pecl install imagick \
 && docker-php-ext-enable imagick

COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./conf/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY ./conf/php.ini /usr/local/etc/php/

WORKDIR /var/www

# Download composer installer and install it
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/bin/composer