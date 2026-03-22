FROM php:8.3-fpm-alpine

RUN apk add --no-cache \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        curl-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd curl

# Allow larger uploads (camera images, audio files)
RUN { \
    echo 'upload_max_filesize = 50M'; \
    echo 'post_max_size = 50M'; \
    echo 'max_execution_time = 300'; \
    } > /usr/local/etc/php/conf.d/uploads.ini

COPY entrypoint.sh /entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
