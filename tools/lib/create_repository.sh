#!/bin/bash

# Liste des répertoires à créer (hors Docker)
DIRS=(
  "$PROJECT_NAME/src/Domain/Model"
  "$PROJECT_NAME/src/Domain/Repository"
  "$PROJECT_NAME/src/Application"
  "$PROJECT_NAME/src/Infrastructure/Persistence"
  "$PROJECT_NAME/src/Infrastructure/Http"
  "$PROJECT_NAME/config"
  "$PROJECT_NAME/public"
  "$PROJECT_NAME/docker/php"
)

# Création des répertoires uniquement s'ils n'existent pas
echo "🚀 Création de la structure du projet : $PROJECT_NAME..."
for DIR in "${DIRS[@]}"; do
  if [ ! -d "$DIR" ]; then
    mkdir -p "$DIR"
    echo "📁 Dossier créé : $DIR"
  else
    echo "⚠️ Le dossier $DIR existe déjà."
  fi
done