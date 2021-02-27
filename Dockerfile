FROM debian:buster

#installing
RUN apt-get update
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install mariadb-server
RUN apt-get -y install php-fpm php-mysql php-mbstring
RUN apt-get -y install vim

#nginx 
COPY 	srcs/nginx.conf etc/nginx/conf.d

#wp
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz && mv wordpress /var/www/html/
RUN rm -rf latest.tar.gz
COPY srcs/wp-config.php /var/www/html/wordpress

#php
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN tar -xzvf phpMyAdmin-5.0.4-all-languages.tar.gz && mv phpMyAdmin-5.0.4-all-languages/ /var/www/html/phpmyadmin
RUN rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz
COPY srcs/config.inc.php /var/www/html/phpmyadmin

#ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/ssl.key -out /etc/ssl/ssl -subj "/C=RU/ST=Tatarstan/L=Kazan/O=21 school/OU=ltanisha/CN=localhost"

#giving rights
RUN chown -R www-data:www-data /var/www/html/*

#copying scripts into initial dir
COPY srcs/*.sh ./

EXPOSE 80 443
CMD bash init.sh
