# #!/bin/sh

# # Schema Avro inline
# SCHEMA='{"type":"record","name":"User","fields":[{"name":"name","type":"string"},{"name":"age","type":"int"}]}'

# docker exec -i schema-registry kafka-avro-console-producer \
#   --broker-list broker:29092 \
#   --topic avro-topic \
#   --property value.schema="$SCHEMA" \
#   --property schema.registry.url=http://schema-registry:8081 <<EOF
# {"name": "Carlos", "age": 43}
# {"name": "Maria", "age": 35}
# EOF

#!/bin/bash

SCHEMA_FILE="./schema.avsc"
DATA_FILE="./data.json"
TOPIC="avro-topic"
SCHEMA_REGISTRY_URL="http://schema-registry:8081"
BROKER="broker:29092"

if [[ ! -f "$SCHEMA_FILE" ]]; then
  echo "Arquivo $SCHEMA_FILE não encontrado!"
  exit 1
fi

if [[ ! -f "$DATA_FILE" ]]; then
  echo "Arquivo $DATA_FILE não encontrado!"
  exit 1
fi

SCHEMA_CONTENT=$(cat "$SCHEMA_FILE" | tr -d '\n')

docker exec -i schema-registry kafka-avro-console-producer \
  --broker-list "$BROKER" \
  --topic "$TOPIC" \
  --property value.schema="$SCHEMA_CONTENT" \
  --property schema.registry.url="$SCHEMA_REGISTRY_URL" < "$DATA_FILE"
