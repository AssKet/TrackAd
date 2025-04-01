FROM php:8.1-fpm-alpine as base

RUN apk add --no-cache \
    bash \
    libzip-dev \
    libpng-dev \
    libjpeg-turbo-dev \
    libfreetype6-dev \
    zlib-dev \
    git \
    unzip \
    icu-dev \
    libxml2-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql intl opcache xml \
    && rm -rf /var/cache/apk/*

FROM base as composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

FROM base as build
WORKDIR /var/www
COPY . .

RUN composer install --no-dev --optimize-autoloader --no-interaction

RUN php bin/console cache:clear --env=prod --no-warmup
RUN php bin/console doctrine:migrations:migrate --no-interaction --env=prod

RUN rm -rf .git

FROM base as final
WORKDIR /var/www
COPY --from=build /var/www /var/www

RUN chown -R www-data:www-data /var/www/var /var/www/public


EXPOSE 9000

CMD ["php-fpm"]
