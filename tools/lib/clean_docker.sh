#!/bin/bash

echo "🛑 Suppression complète des conteneurs Docker existants pour le projet '$PROJECT_NAME'..."
docker compose -f "$PROJECT_NAME/docker-compose.yml" down --remove-orphans 2>/dev/null || true
docker rm -f $(docker ps -aq --filter "name=${PROJECT_NAME}_") 2>/dev/null || true
echo "✅ Conteneurs supprimés."