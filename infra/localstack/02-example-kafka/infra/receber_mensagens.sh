
#!/bin/bash

# Verifica se o nome do tópico foi informado
if [ -z "$1" ]; then
  echo "Uso: ./consumir_mensagens.sh <nome-do-topico> [quantidade]"
  exit 1
fi

TOPICO=$1
QUANTIDADE=${2:-50}  # padrão: 50 mensagens
CONTAINER_NAME="redpanda"

echo "📥 Consumindo $QUANTIDADE mensagens do tópico: $TOPICO com metadados"

docker exec -i "$CONTAINER_NAME" rpk topic consume "$TOPICO" \

