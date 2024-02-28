#!/bin/bash

echo 'Creating Queue'
ls

aws --endpoint-url=http://127.0.0.1:4566 sqs create-queue --queue-name my-queue-sqs-local --region us-east-1 #--attributes '{"defaultVisibilityTimeout":"7200"}'
aws --endpoint-url=http://127.0.0.1:4566 sqs create-queue --queue-name my-queue-sqs-local-dlq --region us-east-1 #--attributes '{"defaultVisibilityTimeout":"7200"}'

echo 'Creating Bucket'
ls
aws --endpoint-url=http://127.0.0.1:4566 s3 mb s3://my-bucket-local
aws --endpoint-url=http://127.0.0.1:4566 s3api put-bucket-acl --bucket my-bucket-local --acl public-read
aws --endpoint-url=http://127.0.0.1:4566 s3api put-object --bucket my-bucket-local --key project/receive

aws --endpoint-url=http://localhost:4566 s3api put-bucket-notification-configuration --bucket my-bucket-local --notification-configuration file://sqs-s3-notification.json

echo 'Created Queues'
aws --endpoint-url=http://127.0.0.1:4566 sqs list-queues

echo 'Created Buckets'
aws --endpoint-url=http://127.0.0.1:4566 s3api list-buckets --query "Buckets[].Name"

echo "Initialization complete."