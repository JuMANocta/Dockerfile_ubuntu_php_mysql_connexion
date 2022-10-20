-- création d'un USER 'host' avec un password 'passw0rd'
CREATE USER 'host'@'%' IDENTIFIED BY 'passw0rd';
-- mise en place des privilèges tel que ceux 'root'
-- Attention ce type de ligne SQL est dangereuse en production
-- Bonne pratique créer un utilisateur spécifique pour gérer ça propre base de donnée
GRANT ALL PRIVILEGES ON *.* TO 'host'@'%';
-- mettre à jour la base àavec les nouvelles informations 'CREATE GRANT'
FLUSH PRIVILEGES;