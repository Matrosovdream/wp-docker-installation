FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    unzip \
    zip \
    libzip-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libicu-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    default-mysql-client \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        mysqli \
        pdo \
        pdo_mysql \
        zip \
        gd \
        intl \
        mbstring \
        exif \
    && rm -rf /var/lib/apt/lists/*

# Install supercronic (cron for containers)
ENV SUPERCRONIC_URL=https://github.com/aptible/supercronic/releases/download/v0.2.33/supercronic-linux-arm64 \
    SUPERCRONIC_SHA1SUM=e0f0c06ebc5627e43b25475711e694450489571

RUN curl -fsSL "${SUPERCRONIC_URL}" -o /usr/local/bin/supercronic \
    && chmod +x /usr/local/bin/supercronic

# Add wp-cron crontab
COPY wp-cron.crontab /etc/wp-cron.crontab

# Add entrypoint that starts supercronic + php-fpm
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["entrypoint.sh"]
