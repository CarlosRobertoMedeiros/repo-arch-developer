#!/bin/bash

TOPIC="${1:-AAA}"  # Usa "AAA" como padrão se nenhum argumento for passado

for i in {1..50}; do
  docker exec -i kafka1 kafka-console-producer \
    --bootstrap-server kafka1:29092 \
    --topic "$TOPIC" <<< "mensagem-$i"
done