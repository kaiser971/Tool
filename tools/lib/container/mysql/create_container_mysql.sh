#!/bin/bash

if [[ "$USE_MYSQL" =~ ^[Yy]$ ]]; then
  read -p "Enter MySQL username: " MYSQL_USER
  read -sp "Enter MySQL password: " MYSQL_PASSWORD
  echo ""
  read -p "Enter MySQL database name: " MYSQL_DATABASE

  MYSQL_USER=${MYSQL_USER:-"user"}
  MYSQL_PASSWORD=${MYSQL_PASSWORD:-"password"}
  MYSQL_DATABASE=${MYSQL_DATABASE:-"app_db"}
  MYSQL_HOST="localhost"

  export MYSQL_USER
  export MYSQL_PASSWORD
  export MYSQL_DATABASE
  export MYSQL_HOST

  cat <<EOL >> "$COMPOSE_FILE"
  mysql:
    image: mysql:8
    container_name: ${PROJECT_NAME}_mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: $MYSQL_PASSWORD
      MYSQL_DATABASE: $MYSQL_DATABASE
      MYSQL_USER: $MYSQL_USER
      MYSQL_PASSWORD: $MYSQL_PASSWORD
    ports:
      - "3306:3306"
    volumes:
      - mysql_data:/var/lib/mysql
    networks:
      - app_network
EOL
fi
