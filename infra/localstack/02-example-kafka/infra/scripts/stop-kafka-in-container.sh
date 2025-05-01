#!/bin/bash

# Nome do broker Kafka a ser parado. Pode ser kafka1, kafka2 ou kafka3.
BROKER_NAME=$1

# Verifica se o nome foi passado
if [ -z "$BROKER_NAME" ]; then
  echo "Uso: ./stop-kafka-broker.sh kafka1|kafka2|kafka3"
  exit 1
fi

# Verifica se o container está rodando
if docker ps --format '{{.Names}}' | grep -q "^$BROKER_NAME$"; then
  echo "Parando o container $BROKER_NAME..."
  docker stop $BROKER_NAME
  echo "$BROKER_NAME parado com sucesso."
else
  echo "Container $BROKER_NAME nao esta rodando ou nao existe."
fi
