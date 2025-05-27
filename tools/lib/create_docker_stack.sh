#!/bin/bash
echo "Quels conteneurs Docker souhaitez-vous mettre en place ?"
while true; do
  read -p "[y/n] Activer Nginx ? [Y] " USE_NGINX
  USE_NGINX=${USE_NGINX:-"y"}
  [[ "$USE_NGINX" =~ ^[YyNn]$ ]] && break
done

while true; do
  read -p "[y/n] Activer MySQL ? [Y] " USE_MYSQL
  USE_MYSQL=${USE_MYSQL:-"y"}
  [[ "$USE_MYSQL" =~ ^[YyNn]$ ]] && break
done

while true; do
  read -p "[y/n] Activer Redis (non recommandé sans modification système) ? [N] " USE_REDIS
  USE_REDIS=${USE_REDIS:-"n"}
  [[ "$USE_REDIS" =~ ^[YyNn]$ ]] && break
done

# Affecter les valeurs par défaut si l'utilisateur n'a pas répondu
USE_NGINX=${USE_NGINX:-"y"}
USE_MYSQL=${USE_MYSQL:-"y"}
USE_REDIS=${USE_REDIS:-"n"}

# Exporter les variables pour qu'elles soient accessibles dans les fichiers sources
export USE_NGINX
export USE_MYSQL
export USE_REDIS

# Génération dynamique du docker-compose.yml
COMPOSE_FILE="$PROJECT_NAME/docker-compose.yml"
export COMPOSE_FILE

# Création du fichier docker-compose.yml
echo "version: '3.8'" > "$COMPOSE_FILE"
echo "" >> "$COMPOSE_FILE"
echo "services:" >> "$COMPOSE_FILE"

####################REDIS CONTAINER##########################
source tools/lib/container/redis/create_container_redis.sh
####################NGINX CONTAINER##########################
source tools/lib/container/nginx/create_container_nginx.sh
####################MYSQL CONTAINER##########################
source tools/lib/container/mysql/create_container_mysql.sh
####################PHP CONTAINER############################
source tools/lib/container/php/create_container_php.sh
############################NETWORKS############################
source tools/lib/container/create_network.sh
############################VOLUME###############################
source tools/lib/container/create_volume.sh

echo "✅ Docker-compose.yml généré avec les services sélectionnés."