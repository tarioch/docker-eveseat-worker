FROM php:7.1-alpine

RUN apk add --no-cache \
    # Install OS level dependencies
    git zip unzip curl \
    libpng-dev libmcrypt-dev bzip2-dev icu-dev mariadb-client && \
    # Install PHP dependencies
    docker-php-ext-install pdo_mysql gd bz2 intl mcrypt pcntl && \
    # Prepare composer for use
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    # Prepare the /var/www directory for SeAT
    mkdir -p /var/www && cd /var/www && \
    # And install SeAT
    composer create-project eveseat/seat --stability beta --no-dev --no-ansi --no-progress

COPY startup.sh /root/startup.sh
RUN chmod +x /root/startup.sh

ENTRYPOINT ["/bin/sh", "/root/startup.sh"]
