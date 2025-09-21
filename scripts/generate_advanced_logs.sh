#!/usr/bin/env bash
# Bash script to create a demo Elasticsearch index and generate sample log events
# Useful for local testing of ELK pipelines and Kibana dashboards

set -euo pipefail
ES_URL="${ES_URL:-http://localhost:9200}"
INDEX="${INDEX:-student_logs}"
COUNT="${COUNT:-50}"
echo "Creating index: $INDEX (if not exists)"
curl -s -X PUT "$ES_URL/$INDEX" -H 'Content-Type: application/json' -d '{
  "settings": { "number_of_shards": 1, "number_of_replicas": 0 },
  "mappings": {
    "properties": {
      "timestamp": { "type": "date" },
      "user": { "type": "keyword" },
      "action": { "type": "keyword" },
      "product": { "type": "keyword" },
      "status_code": { "type": "integer" },
      "duration_ms": { "type": "integer" }
    }
  }
}' >/dev/null || true
echo "Generating $COUNT demo events to $INDEX ..."
USERS=("daniel" "maya" "ron" "lee" "noa" "yossi")
ACTIONS=("view" "add_to_cart" "purchase" "login" "logout")
PRODUCTS=("book" "laptop" "shoes" "phone" "backpack")
bulk_file="$(mktemp)"
now_ms=$(($(date +%s%N)/1000000))
for i in $(seq 1 "$COUNT"); do
  user=${USERS[$RANDOM % ${#USERS[@]}]}
  action=${ACTIONS[$RANDOM % ${#ACTIONS[@]}]}
  product=${PRODUCTS[$RANDOM % ${#PRODUCTS[@]}]}
  status=$(( (RANDOM % 20 == 0) ? ( (RANDOM % 3)*100 + 400 ) : 200 ))
  duration=$((RANDOM % 900 + 50))
  ts_ms=$(( now_ms - (RANDOM % 3600000) ))
  echo '{ "index": { "_index": "'"$INDEX"'" } }' >> "$bulk_file"
  printf '{"timestamp":"%s","user":"%s","action":"%s","product":"%s","status_code":%d,"duration_ms":%d}\n' \
    "$(date -u -d "@$((ts_ms/1000))" +%Y-%m-%dT%H:%M:%SZ)" \
    "$user" "$action" "$product" "$status" "$duration" >> "$bulk_file"
done
curl -s -H "Content-Type: application/x-ndjson" -X POST "$ES_URL/_bulk" --data-binary "@$bulk_file" >/dev/null
rm -f "$bulk_file"
echo "Done."
echo "Count:"
curl -s "$ES_URL/$INDEX/_count?pretty"
