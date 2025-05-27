#!/bin/bash
echo "🔍 Vérification des prérequis..."
command -v docker >/dev/null 2>&1 || { echo "❌ Docker n'est pas installé. Installez-le et réessayez."; exit 1; }
command -v composer >/dev/null 2>&1 || { echo "❌ Composer n'est pas installé. Installez-le et réessayez."; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "❌ npm n'est pas installé. Installez-le et réessayez."; exit 1; }
# Vérifier la présence de Composer
if ! command -v composer &> /dev/null; then
    echo "❌ Erreur : Composer n'est pas installé sur votre machine."
    echo "💡 Installez Composer avec : https://getcomposer.org/download/"
    exit 1
fi

echo "✅ Tous les prérequis sont satisfaits."