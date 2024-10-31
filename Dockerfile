# Dockerfile

FROM ubuntu:20.04

# Installer NGINX
RUN apt-get update && \
    apt-get install -y nginx && \
    echo 'Hello les amis' > /var/www/html/index.html

# Exposer le port 80 pour NGINX
EXPOSE 80

# Commande pour démarrer NGINX
CMD ["nginx", "-g", "daemon off;"]
