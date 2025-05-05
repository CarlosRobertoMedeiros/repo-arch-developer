#!/bin/bash

# Verifica se o nome do tópico foi informado
if [ -z "$1" ]; then
  echo "Uso: ./enviar_mensagens.sh <nome-do-topico>"
  exit 1
fi

TOPIC_NAME=$1
CONTAINER_NAME="redpanda"

# Listas básicas de nomes e sobrenomes (você pode expandir)
NOMES=("Ana" "Bruno" "Carlos" "Daniela" "Eduardo" "Fernanda" "Gabriel" "Helena" "Igor" "Juliana")
SOBRENOMES=("Silva" "Souza" "Oliveira" "Pereira" "Lima" "Costa" "Almeida" "Gomes" "Ribeiro" "Martins")

echo "📤 Enviando 50 mensagens JSON para o tópico: $TOPIC_NAME"

for i in $(seq 1 50); do
  # Gera nome e sobrenome aleatórios
  NOME=${NOMES[$RANDOM % ${#NOMES[@]}]}
  SOBRENOME=${SOBRENOMES[$RANDOM % ${#SOBRENOMES[@]}]}

  # Cria JSON
  JSON="{\"nome\": \"$NOME\", \"sobrenome\": \"$SOBRENOME\"}"

  # Envia a mensagem JSON para o Redpanda via docker exec
  docker exec -i "$CONTAINER_NAME" rpk topic produce "$TOPIC_NAME" <<< "$JSON"

  echo "✔️ Enviada: $JSON"
done

echo "✅ Todas as mensagens foram enviadas com sucesso!"
