FROM nginx
MAINTAINER Daniel Paschke <paschdan@gmail.com>

RUN apt-get update -y && apt-get install -y php5-fpm php5-intl php-apc php5-gd php5-intl php5-mysqlnd php5-pgsql php-pear php5-cli && rm -rf /var/lib/apt/lists/*

# Once we start using PHP, it will dictate the use of www-data, so use that instead of nginx
RUN sed -i 's/user  nginx/user  www-data/g' /etc/nginx/nginx.conf

# Force PHP to log to nginx
RUN echo "catch_workers_output = yes" >> /etc/php5/fpm/php-fpm.conf

COPY docker /
COPY . /var/www

ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod +x /usr/local/bin/composer

RUN chown -R www-data:www-data /var/www

WORKDIR /var/www

# Enable php by default
CMD service php5-fpm start && nginx -g "daemon off;"
