#!/bin/bash

# Aller au répertoire parent (sortir de `tools/`)
cd "$(dirname "$0")/.." || exit
pwd
# Vérifier les prérequis
source tools/lib/check_requirements.sh

# Check projet
source tools/lib/check_project_name.sh

# Suppression complète des conteneurs liés au projet
source tools/lib/clean_docker.sh

# Création de la structure du projet
source tools/lib/create_repository.sh

# Création stack docker
source tools/lib/create_docker_stack.sh

# Creation de la page d'accueil
source tools/lib/create_index.sh

# Selection du framework
source tools/lib/select_framework.sh

# Démarrer les conteneurs
source tools/lib/launch_container.sh
