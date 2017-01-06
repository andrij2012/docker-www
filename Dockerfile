FROM php:7.0.14-apache

# Add SSH-keys
ADD ssh /root/.ssh
ADD php.ini /usr/local/etc/php

 # Install additional packages
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
      git \
      imagemagick \
      ssh-client \
      libfreetype6-dev \
      libpng12-dev \
      libjpeg62-turbo-dev \
      libxml2-dev \

 # Initialize default virtual host
 && echo '<VirtualHost *:80> \n\
    ServerName localhost \n\
    DocumentRoot /var/www/html/web \n\
    ErrorLog ${APACHE_LOG_DIR}/error.log \n\
    CustomLog ${APACHE_LOG_DIR}/access.log combined \n\
\n\
    <Directory /var/www/html/web> \n\
        Options +Indexes +FollowSymLinks \n\
        AllowOverride All \n\
    </Directory> \n\
</VirtualHost>' > /etc/apache2/sites-enabled/000-default.conf \

 # Enable rewrite apache2 module
 && a2enmod rewrite \

 # Enable PHP-extensions
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) \
       soap \
       mysqli \
       opcache \
       zip \
       gd \
 && pecl install xdebug \
 && docker-php-ext-enable xdebug \

 # Install composer
 && php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/bin/composer \

 # Change owner and group for ssh-keys
 && chown root:root /root/.ssh

EXPOSE 80
