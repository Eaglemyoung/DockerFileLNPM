#
# Eagle's Docker stack
#
# PHP Dockerfile
#

# Base image
FROM debian:testing

# Update apt
RUN apt-get update

# Install PHP5
RUN apt-get install -y \
        php5-fpm php5-mysql\
        && sed 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf

# Define default command
CMD ["php5-fpm"]
