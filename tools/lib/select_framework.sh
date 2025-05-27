#!/bin/bash
# Sélection du framework (avec option "Aucun")
echo "Quel framework souhaitez-vous utiliser ?"
select FRAMEWORK in "Symfony" "Laravel" "Aucun"; do
  case $FRAMEWORK in
    Symfony )
      FRAMEWORK_ARG="symfony"
      break;;
    Laravel )
      FRAMEWORK_ARG="laravel"
      break;;
    Aucun )
      FRAMEWORK_ARG=""
      break;;
    * )
      echo "❌ Choix invalide, veuillez sélectionner 1 (Symfony), 2 (Laravel) ou 3 (Aucun).";;
  esac
done

# Vérifier si le dossier du framework est vide
if [ ! -d "$PROJECT_NAME/src/Infrastructure/Http/vendor" ]; then
  echo "📥 Installation du framework en local avant de lancer Docker..."
  if [ "$FRAMEWORK_ARG" = "symfony" ]; then
    composer create-project symfony/skeleton "$PROJECT_NAME/src/Infrastructure/Http/"
  elif [ "$FRAMEWORK_ARG" = "laravel" ]; then
    composer create-project --prefer-dist laravel/laravel "$PROJECT_NAME/src/Infrastructure/Http/"
  fi
  # Vérification de l'installation réussie
  if [ ! -d "$PROJECT_NAME/src/Infrastructure/Http/vendor" ]; then
    echo "❌ Erreur lors de l'installation de $FRAMEWORK_ARG. Vérifiez votre connexion internet ou les permissions."
    exit 1
  fi
  echo "✅ $FRAMEWORK_ARG installé avec succès."
else
  echo "⚠️ Aucun framework installé."
fi