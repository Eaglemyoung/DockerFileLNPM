FROM debian:testing

RUN apt-get update 
RUN apt-get install -y \
        php5-fpm php5-mysql\
        && sed 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf

CMD ["php5-fpm"]
