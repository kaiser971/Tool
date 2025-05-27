#!/bin/bash

echo "✅ Création de stack pour PHP."
# Création du Dockerfile PHP
cat <<EOL > "$PROJECT_NAME/docker/php/Dockerfile"
FROM php:8.2-fpm

RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    libonig-dev \
    libxml2-dev \
    && docker-php-ext-install pdo_mysql xml

RUN docker-php-ext-enable pdo_mysql xml

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

EOL

cat <<EOL >> "$COMPOSE_FILE"
  php:
    build:
      context: ./docker/php
      args:
        FRAMEWORK: "none"
    container_name: ${PROJECT_NAME}_php
    volumes:
      - ./:/var/www/html
    environment:
      APP_ENV: dev
EOL
if [[ "$USE_MYSQL" =~ ^[Yy]$ ]]; then
  cat <<EOL >> "$COMPOSE_FILE"
      MYSQL_ROOT_PASSWORD: $MYSQL_PASSWORD
      MYSQL_DATABASE: $MYSQL_DATABASE
      MYSQL_USER: $MYSQL_USER
      MYSQL_PASSWORD: $MYSQL_PASSWORD
EOL
fi
cat <<EOL >> "$COMPOSE_FILE"
    networks:
      - app_network
EOL
if [[ "$USE_MYSQL" =~ ^[Yy]$ ]]; then
  echo "    depends_on:" >> "$COMPOSE_FILE"
  echo "      - mysql" >> "$COMPOSE_FILE"
fi

echo "✅ Fichier Dockerfile créé pour PHP."