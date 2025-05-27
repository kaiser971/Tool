#!/bin/bash

if [[ "$USE_NGINX" =~ ^[Yy]$ ]]; then
  mkdir -p "$PROJECT_NAME/docker/nginx"
  echo "✅ Dossier Nginx créé."
  echo "Création du fichier de configuration Nginx..."

  cat > "$PROJECT_NAME/docker/nginx/default.conf" <<EOL
server {
    listen 80;
    server_name localhost;

    root /var/www/html/public;
    index index.php index.html index.htm;

    location / {
        try_files \$uri /index.php\$is_args\$args;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass php:9000;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
    }

    error_log  /var/log/nginx/error.log warn;
    access_log /var/log/nginx/access.log main;
}
EOL

  echo "✅ Fichier de configuration Nginx créé."

  cat >> "$COMPOSE_FILE" <<EOL
  nginx:
    image: nginx:latest
    container_name: ${PROJECT_NAME}_nginx
    ports:
      - "8080:80"
    volumes:
      - ./public:/var/www/html/public
      - ./docker/nginx/default.conf:/etc/nginx/conf.d/default.conf
    depends_on:
      - php
    networks:
      - app_network
EOL
fi