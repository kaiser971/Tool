#!/bin/bash
# Vérifier si le projet est déjà dans le bon répertoire
if [[ "$(basename $(pwd))" != "$PROJECT_NAME" ]]; then
  echo "📂 Ouvrir le répertoire du projet '$PROJECT_NAME'..."
  cd "$PROJECT_NAME" || exit
fi

if [ -z "$FRAMEWORK_ARG" ]; then
  echo "❌ Aucun framework sélectionné, annulation du build."
  exit 1
fi
# Passer l'argument FRAMEWORK au build Docker
echo "🚀 Construction de l'image PHP avec $FRAMEWORK_ARG..."
pwd
docker compose -f docker-compose.yml build --build-arg FRAMEWORK="$FRAMEWORK_ARG"

# Démarrer les conteneurs
echo "🚀 Démarrage des conteneurs Docker..."
docker compose -f docker-compose.yml up -d

# Vérification si les conteneurs sont bien lancés
if ! docker ps --format "{{.Names}}" | grep -q "${PROJECT_NAME}_php"; then
  echo "❌ Erreur : Le conteneur PHP ne semble pas démarré. Vérifiez les logs avec 'docker compose logs'."
  exit 1
fi

echo "✅ Structure du projet '$PROJECT_NAME' créée avec succès !"

# Ouvrir le navigateur
echo "🌐 Ouvrir le navigateur pour accéder à http://localhost:8080..."
