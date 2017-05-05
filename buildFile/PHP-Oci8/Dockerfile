FROM debian:testing

RUN apt-get update  
RUN apt-get install -y \
        php7.0-fpm libaio1 php7.0-dev php7.0-mysql php-memcached \
        && sed 's/;daemonize = yes/daemonize = no/' -i /etc/php/7.0/fpm/php-fpm.conf

ADD /oracle/oracle-instantclient12.1-basic_12.1.0.2.0-1_amd64.deb   /tmp/oracle-instantclient12.1-basic_12.1.0.2.0-1_amd64.deb
ADD /oracle/oracle-instantclient12.1-devel_12.1.0.2.0-1_amd64.deb   /tmp/oracle-instantclient12.1-devel_12.1.0.2.0-1_amd64.deb
ADD /oracle/oracle-instantclient12.1-sqlplus_12.1.0.2.0-1_amd64.deb /tmp/oracle-instantclient12.1-sqlplus_12.1.0.2.0-1_amd64.deb

RUN dpkg -i /tmp/oracle-instantclient12.1-basic_12.1.0.2.0-1_amd64.deb 
RUN dpkg -i /tmp/oracle-instantclient12.1-devel_12.1.0.2.0-1_amd64.deb
RUN dpkg -i /tmp/oracle-instantclient12.1-sqlplus_12.1.0.2.0-1_amd64.deb

ENV LD_LIBRARY_PATH /usr/lib/oracle/12.1/client64/lib
ENV ORACLE_HOME /usr/lib/oracle/12.1/client64 

ADD php/oci8.ini /etc/php/7.0/mods-available/oci8.ini

ADD oci8 /oci8

RUN cd /oci8 \
    && phpize \
    && ./configure --with-oci8=share,instantclient,/usr/lib/oracle/12.1/client64/lib \
    && make \
    && make install

RUN ln -s /etc/php/7.0/mods-available/oci8.ini /etc/php/7.0/fpm/conf.d/20-oci8.ini
RUN apt-get clean -y

RUN service php7.0-fpm start

CMD ["php-fpm7.0"]
