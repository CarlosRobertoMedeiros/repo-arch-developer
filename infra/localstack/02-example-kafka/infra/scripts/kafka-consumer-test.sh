#!/bin/bash

TOPIC="${1:-AAA}"  # Usa "AAA" se nenhum tópico for passado como argumento

docker exec -i kafka1 kafka-console-consumer \
  --bootstrap-server kafka1:29092 \
  --topic "$TOPIC" \
  --from-beginning \
  --property print.partition=true
