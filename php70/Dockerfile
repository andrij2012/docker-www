FROM php:7.0.5-fpm
RUN apt-get update && apt-get install -y \
        apt-utils \
        curl \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
 && rm -r /var/lib/apt/lists/*

# Install required PHP extension
RUN docker-php-ext-install -j$(nproc) mcrypt \
                                      soap \
                                      xml \
                                      zip \
                                      mysqli \
                                      json \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install XDebug
RUN pecl install xdebug \
  && docker-php-ext-enable xdebug