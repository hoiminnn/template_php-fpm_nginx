FROM php:8.2-fpm-alpine

RUN apk add --no-cache nginx supervisor curl fcgi 

RUN mkdir -p /var/run/php-fpm \
&& touch /var/run/php-fpm/php-fpm.sock \
&& chown www-data:www-data /var/run/php-fpm/php-fpm.sock 

COPY configs/supervisord/supervisord.conf /etc/supervisord.conf
COPY configs/nginx/default.conf /etc/nginx/http.d/default.conf
COPY configs/nginx/nginx.conf /etc/nginx/nginx.conf
COPY configs/php-fpm/www.conf /usr/local/etc/php-fpm.d/www.conf
COPY configs/php-fpm/zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY --chown=www-data:www-data src/ /var/www/html

CMD []
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]