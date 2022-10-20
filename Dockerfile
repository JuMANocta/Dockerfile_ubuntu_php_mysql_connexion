# FROM permet de chosir son image de base ici UBUNTU
FROM ubuntu

# Différentes actions RUN pour agir lors de la création de l'image
RUN apt update
RUN apt install apache2 apache2-utils -y
RUN apt install mysql-server -y
# L'installation de PHP demande une information de l'utilisateur, 'nointeractive' permet forcer à ne pas avoir de demande utilisateur
RUN DEBIAN_FRONTEND='nointeractive' apt install php -y
RUN apt install libapache2-mod-php php-mysql -y
# Permet de clean les packages non essentiels
RUN apt clean && apt autoclean && apt auto-remove -y
# ajouter l'utilisateur mysql à son application
RUN usermod -d /var/lib/mysql mysql
# modification du fichier mysqld.conf afin d'ouvrir la BDD vers l'extérieur
RUN sed -i 's/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf
# Copier le fichier init.sql afin d'être lancé par la suite
COPY init.sql /

# Expose les ports du conteneur afin de pouvoir les fowards lors du run du conteneur
EXPOSE 80
EXPOSE 3306

# Permet de lancer plusieurs actions afin d'avoir un conteneur auto-actif Apache2 mysql
ENTRYPOINT service apache2 start \
&& service mysql start \
&& mysql -u root < init.sql \
&& /bin/bash

# Création de l'image
# docker build -t lamp .
# Création du conteneur
# docker run -d -it -p 80:80/tcp -p 3306:3306/tcp lamp