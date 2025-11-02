#!/usr/bin/env bash
set -e

# Caminho absoluto do diretório atual (onde o script foi chamado)
BASE_DIR="$(pwd)"

# Caminho do arquivo docker-compose relativo ao diretório atual
STACK_FILE="${BASE_DIR}/infra/stack.yml"

# Verifica se o arquivo stack.yml existe
if [ ! -f "$STACK_FILE" ]; then
  echo "❌ Arquivo 'stack.yml' não encontrado em: $STACK_FILE"
  exit 1
fi

echo "📦 Diretório base: $BASE_DIR"
echo "🧩 Usando stack: $STACK_FILE"
echo

# Ação padrão é "restart" se não for passada como argumento
ACTION="${1:-restart}"
ACTION_DONE=""

case "$ACTION" in
  up)
    echo "🧹 Limpando stack anterior..."
    docker-compose -f "$STACK_FILE" down --remove-orphans >/dev/null 2>&1 || true
    echo "🚀 Subindo stack..."
    docker-compose -f "$STACK_FILE" up -d
    ACTION_DONE="Subida (up)"
    ;;
  down)
    echo "🧹 Derrubando stack..."
    docker-compose -f "$STACK_FILE" down
    ACTION_DONE="Derrubada (down)"
    ;;
  restart)
    echo "♻️ Reiniciando stack..."
    docker-compose -f "$STACK_FILE" down --remove-orphans >/dev/null 2>&1 || true
    docker-compose -f "$STACK_FILE" up -d
    ACTION_DONE="Reiniciada (restart)"
    ;;
  *)
    echo "❌ Uso: $0 [up|down|restart]"
    exit 1
    ;;
esac

# Mostra logs em tempo real após up ou restart
if [[ "$ACTION" == "up" || "$ACTION" == "restart" ]]; then
  echo
  echo "📄 Exibindo logs da stack em tempo real (Ctrl+C para sair)..."
  docker-compose -f "$STACK_FILE" logs -f --no-color
fi


echo
echo "✅ Operação concluída com sucesso!"
echo "📣 Ação executada: $ACTION_DONE"