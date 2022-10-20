FROM ubuntu

RUN apt update
RUN apt install apache2 apache2-utils -y
RUN apt install mysql-server -y
RUN DEBIAN_FRONTEND='nointeractive' apt install php -y
RUN apt install libapache2-mod-php php-mysql -y
RUN apt install systemctl -y
RUN apt clean && apt autoclean && apt auto-remove -y
RUN usermod -d /var/lib/mysql mysql
RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
COPY init.sql /


EXPOSE 80
EXPOSE 3306

ENTRYPOINT service apache2 start \
&& service mysql start \
&& mysql -u root < init.sql \
&& /bin/bash

# Création de l'image
# docker build -t lamp .
# Création du conteneur
# docker run -d -it -p 80:80/tcp -p 3306:3306/tcp lamp