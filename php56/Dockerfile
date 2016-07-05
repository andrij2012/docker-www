FROM php:5.6-fpm
RUN apt-get update && apt-get install -y apt-utils wget curl libfreetype6-dev libjpeg62-turbo-dev \
                                         libmcrypt-dev libpng12-dev libxml2-dev git vim \
                                         libgraphicsmagick1-dev libmagickwand-dev imagemagick graphicsmagick \
 && rm -r /var/lib/apt/lists/*

# Install required PHP extension
RUN docker-php-ext-install -j$(nproc) mcrypt soap xml zip mysqli json \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd

# Install Xdebug, Imagemagick and GraphicsMagick
RUN pecl install xdebug \
 # && pecl install gmagick-2.0.2RC2 \
 # && pecl install imagick \
 # && docker-php-ext-enable xdebug \
 && docker-php-ext-enable xdebug
 # && docker-php-ext-enable gmagick \
 # && docker-php-ext-enable imagick

COPY ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY ./conf/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf

WORKDIR /var/www

# Download composer installer and install it
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/bin/composer \
 && useradd -ms /bin/bash www