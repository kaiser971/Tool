#!/bin/bash
read -p "Entrez le nom du projet : " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
  echo "❌ Erreur : Vous devez entrer un nom de projet."
  exit 1
fi
export PROJECT_NAME
