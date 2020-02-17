FROM phpdockerio/php74-fpm:latest

# Fix debconf warnings upon build
ARG DEBIAN_FRONTEND=noninteractive
ARG ENV_TZ

ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=1 \
    COMPOSER_ALLOW_SUPERUSER=1

RUN if [ -z "$ENV_TZ"]; \
    then echo "timezone argument is empty - not setting" ; \
    else ln -snf /usr/share/zoneinfo/$ENV_TZ /etc/localtime && echo $ENV_TZ > /etc/timezone; \
    fi


# Install selected extensions and other stuff
RUN apt-get update && apt-get -y --no-install-recommends install \
    composer php-memcached php-xdebug php7.4-mysql php7.4-sqlite3 php7.4-bcmath php7.4-amqp php7.4-intl
