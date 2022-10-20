## Utiliser un Jenkinsfile pour créer un LAMP
Créer l'image Docker
```bash
$~ docker build -t lamp .
```
Créer le conteneur
```bash
$~ docker run -it -d -p 80:80/tcp -p 3306:3306/tcp lamp
```
Suite à la mise en place, la base de donnée est disponible depuis l'extérieur du conteneur avec un login:host et pass:passw0rd

Chaque fichier contient des commentaires pour expliquer chaque actions.