#!/bin/bash
if [[ "$USE_REDIS" =~ ^[Yy]$ ]]; then
  echo -e "\n⚠️  ATTENTION : Redis nécessite une modification du noyau de la machine hôte pour éviter des erreurs de mémoire."
  echo -e "🚀  Vous devez exécuter les commandes suivantes sur votre machine hôte avant de démarrer Redis :\n"
  echo -e "    sudo bash -c 'echo \"vm.overcommit_memory = 1\" >> /etc/sysctl.conf'"
  echo -e "    sudo sysctl -w vm.overcommit_memory=1\n"
  echo -e "📌  Sans cette modification, Redis pourrait planter ou ne pas sauvegarder correctement les données."
  echo -e "❌  Si vous ne souhaitez pas modifier votre machine hôte, répondez 'n' à l'activation de Redis.\n"

  mkdir -p "$PROJECT_NAME/docker/redis"
  echo "vm.overcommit_memory = 1" > "$PROJECT_NAME/docker/redis/redis.conf"
  echo "✅ Fichier de configuration Redis créé avec 'vm.overcommit_memory = 1'."

  cat <<EOL >> "$COMPOSE_FILE"
  redis:
    image: redis:latest
    container_name: ${PROJECT_NAME}_redis
    ports:
      - "6379:6379"
    volumes:
      - ./docker/redis/redis.conf:/usr/local/etc/redis/redis.conf
    command: ["redis-server", "/usr/local/etc/redis/redis.conf"]
    networks:
      - app_network
EOL
fi