#!/bin/bash

# Aguarda o Kafka iniciar
sleep 20

# Comando para criar os tópicos
kafka-topics --bootstrap-server kafka:29092 --create --if-not-exists --topic AAA--replication-factor 2 --partitions 3

echo "Topicos criados com sucesso!"

