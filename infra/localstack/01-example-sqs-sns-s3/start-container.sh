#! /usr/bin/env bash

#docker-compose -f authorization_server.yml down
#docker-compose -f authorization_server.yml up -d

docker-compose -f C:/Desenvolvimento/sistemas/arch-developer/infra/localstack/01-example-sqs-sns-s3/infra/stack.yml down
docker-compose -f C:/Desenvolvimento/sistemas/arch-developer/infra/localstack/01-example-sqs-sns-s3/infra/stack.yml up

echo 'Stack started !'