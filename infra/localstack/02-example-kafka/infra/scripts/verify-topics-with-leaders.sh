#!/bin/bash

docker exec -it kafka1 kafka-topics \
  --describe \
  --topic AAA \
  --bootstrap-server kafka1:29092
