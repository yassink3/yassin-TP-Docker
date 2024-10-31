
# Rapport de Projet : Infrastructure Multi-Conteneurs avec Docker Compose

## Introduction

Ce projet a pour objectif de démontrer l'utilisation de Docker et Docker Compose pour créer une infrastructure web multi-conteneurs. L'application comprend un serveur NGINX, un superviseur pour monitorer le nombre de connexions, et un client qui envoie des requêtes HTTP au serveur. Ce rapport présente les étapes de mise en place, la configuration des conteneurs, ainsi que les résultats obtenus.

## Architecture du Projet

L'architecture de l'application repose sur trois conteneurs principaux :

1. **nginx-server** : Serveur web NGINX qui gère les requêtes sur le port 7000.
2. **nginx_supervisor** : Conteneur qui exécute un script Bash pour surveiller et compter le nombre de connexions au serveur.
3. **nginx_curl_client** : Conteneur qui envoie des requêtes HTTP au serveur NGINX à l'aide de l'outil `curl`.

### Diagramme d'Architecture

```plaintext
+------------------+       +-----------------------+
|                  |       |                       |
|  nginx-server    |<----->|  nginx_supervisor     |
|                  |       |                       |
+------------------+       +-----------------------+
                                |
                                |
                                v
                      +-------------------+
                      |                   |
                      |  nginx_curl_client|
                      |                   |
                      +-------------------+
