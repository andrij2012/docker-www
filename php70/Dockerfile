FROM php:7.0.5-fpm
RUN apt-get update && apt-get install -y apt-utils wget curl libfreetype6-dev libjpeg62-turbo-dev \
                                         libmcrypt-dev libpng12-dev libxml2-dev git vim \
 && rm -r /var/lib/apt/lists/*

# Install required PHP extension
RUN docker-php-ext-install -j$(nproc) mcrypt soap xml zip mysqli json \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
 && docker-php-ext-install -j$(nproc) gd

# Install Xdebug
RUN pecl install xdebug \
 && docker-php-ext-enable xdebug

WORKDIR /var/www

# Download composer installer and install it
RUN php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
 && php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '7228c001f88bee97506740ef0888240bd8a760b046ee16db8f4095c0d8d525f2367663f22a46b48d072c816e7fe19959') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
 && php composer-setup.php \
 && php -r "unlink('composer-setup.php');" \
 && mv composer.phar /usr/bin/composer