#!/usr/bin/env bash
# Bash script to continuously stream random log events into Elasticsearch
# Useful for testing real-time ingestion, dashboards, and monitoring

set -euo pipefail
ES_URL="${ES_URL:-http://localhost:9200}"
INDEX="${INDEX:-student_logs}"
INTERVAL="${INTERVAL:-2}"
USERS=("daniel" "maya" "ron" "lee" "noa" "yossi")
ACTIONS=("view" "add_to_cart" "purchase" "login" "logout")
PRODUCTS=("book" "laptop" "shoes" "phone" "backpack")
echo "Streaming logs into index: $INDEX (Ctrl+C to stop)"
while true; do
  user=${USERS[$RANDOM % ${#USERS[@]}]}
  action=${ACTIONS[$RANDOM % ${#ACTIONS[@]}]}
  product=${PRODUCTS[$RANDOM % ${#PRODUCTS[@]}]}
  status=$(( (RANDOM % 15 == 0) ? ( (RANDOM % 3)*100 + 400 ) : 200 ))
  duration=$((RANDOM % 900 + 50))
  ts="$(date -u +%Y-%m-%dT%H:%M:%SZ)"
  curl -s -X POST "$ES_URL/$INDEX/_doc" -H 'Content-Type: application/json' -d @- >/dev/null <<JSON
{"timestamp":"$ts","user":"$user","action":"$action","product":"$product","status_code":$status,"duration_ms":$duration}
JSON
  sleep "$INTERVAL"
done
