#!/bin/bash

if [[ "$USE_MYSQL" =~ ^[Yy]$ ]]; then
  {
    echo "volumes:"
    echo "  mysql_data:"
  } >> "$COMPOSE_FILE"
fi