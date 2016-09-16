FROM php:7.0.5-fpm
RUN apt-get update && apt-get install -y wget \
                                         curl \
                                         libfreetype6-dev \
                                         libjpeg62-turbo-dev \
                                         libmcrypt-dev \
                                         libpng12-dev \
                                         libxml2-dev \
                                         git \
                                         vim \
                                         libgraphicsmagick1-dev \
                                         libmagickwand-dev \
                                         --no-install-recommends \
                                         ghostscript \
                                         libgs-dev \
                                         imagemagick \
                                         graphicsmagick \
                                         sudo \
 && rm -r /var/lib/apt/lists/* \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) mcrypt \
                                      soap \
                                      xml \
                                      zip \
                                      mysqli \
                                      json \
                                      opcache \
                                      pdo_mysql \
                                      gd 
                                      #\
 # && pecl install xdebug 
 # \
 #&& docker-php-ext-enable xdebug

WORKDIR /var/www

# Download composer installer and install it
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/bin/composer \
 && useradd -ms /bin/bash www \
 && echo "www:root" | chpasswd \
 && adduser www sudo

USER www

RUN composer global require "laravel/installer" \
 && echo 'export PATH="$PATH:$HOME/.composer/vendor/bin"' >> ~/.bashrc
