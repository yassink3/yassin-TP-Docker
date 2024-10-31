**Rapport de Projet : Mise en Place d'une Infrastructure Multi-Conteneurs avec Docker et NGINX**
1. Introduction
Ce projet a pour objectif de créer une infrastructure web à l'aide de Docker, qui consiste en un serveur NGINX, un superviseur des connexions, et un client capable d'envoyer des requêtes HTTP au serveur. L'ensemble des fichiers nécessaires a été conservé dans un dépôt Git pour évaluation.

2. Objectifs
Les principaux objectifs de ce projet étaient les suivants :

Créer une image Docker pour un serveur NGINX.
Mettre en place un conteneur de supervision qui comptabilise le nombre de connexions au serveur.
Utiliser un conteneur client pour envoyer des requêtes HTTP vers le serveur.
Configurer un réseau de type bridge pour permettre la communication entre les conteneurs.
Utiliser des volumes Docker pour partager les fichiers de logs entre les conteneurs.
3. Technologies utilisées
Docker : pour la création et la gestion des conteneurs.
Docker Compose : pour orchestrer plusieurs conteneurs.
NGINX : pour servir une page web et gérer les requêtes HTTP.
Bash : pour écrire le script de supervision.
4. Architecture de l'Infrastructure
L'infrastructure est composée de trois conteneurs :

nginx-server : Le serveur web NGINX qui écoute sur le port 7000 et sert une page d'accueil simple.
nginx_supervisor : Un conteneur qui exécute un script Bash pour superviser le nombre de connexions à NGINX, en lisant les logs générés par le serveur.
nginx_curl_client : Un conteneur qui utilise curlpour envoyer des requêtes HTTP au serveur NGINX.
4.1. Dockerfile
Le Dockerfilepour le serveur NGINX est présenté ci-dessous :

Fichier Docker

Copier le code
FROM ubuntu:20.04

RUN apt-get update && \
    apt-get install -y nginx && \
    echo 'Hello les amis' > /var/www/html/index.html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
4.2. Script de supervision
Le script de supervision, nginx-supervisor.sh, compte les requêtes dans le fichier access.logtoutes les 10 secondes :

frapper

Copier le code
#!/bin/bash

while true
do
    cat /servlog/access.log | wc -l
    sleep 10
done
4.3. Configuration de Docker Compose
Le fichier docker-compose.ymldéfinit les services et leur configuration :

YAML

Copier le code
version: '3.8'

services:
  nginx-server:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: nginx_server
    ports:
      - "7000:80"
    volumes:
      - nginx-log:/var/log/nginx
    networks:
      - webnet

  supervisor:
    image: ubuntu:20.04
    container_name: nginx_supervisor
    volumes:
      - ./nginx-supervisor.sh:/servlog/nginx-supervisor.sh
      - nginx-log:/servlog
    networks:
      - webnet
    command: ["/bin/bash", "/servlog/nginx-supervisor.sh"]

  curl-client:
    image: radial/busyboxplus:curl
    container_name: nginx_curl_client
    networks:
      - webnet
    command: ["sh", "-c", "sleep 5; curl http://nginx-server:80"]

volumes:
  nginx-log:

networks:
  webnet:
    driver: bridge
5. Résultats
Après avoir mis en place l'infrastructure, les tests ont montré que :

Le serveur NGINX était accessible sur le port 7000, et la page affichait correctement le message "Hello les amis".
Le superviseur comptabilisait avec succès le nombre de connexions en lisant le fichier access.log.
Le client curlpeut envoyer des requêtes HTTP et recevoir des réponses.
6. Conclusion
Ce projet a permis d'acquérir une meilleure compréhension de l'utilisation de Docker et de Docker Compose pour créer des infrastructures multi-conteneurs. La configuration de NGINX, combinée à un script de supervision et à un client de test, démontre la flexibilité et la puissance de Docker pour déployer des applications web.

6.1. Perspectives
Pour de futurs projets, il serait intéressant d'étendre cette infrastructure en :

Ajoutant une base de données pour stocker des informations.
Implémenter un mécanisme de répartition de charge.
Intégrant un système de surveillance plus avancé pour les performances des conteneurs.
