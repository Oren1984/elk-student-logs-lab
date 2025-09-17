# Quick checks (run after the stack is up)
curl -s "http://localhost:9200/_cluster/health?pretty"
curl -s "http://localhost:9200/student_logs/_count?pretty"
curl -s "http://localhost:9200/student_logs/_search?size=5&pretty"

# Search by user (daniel)
curl -s "http://localhost:9200/student_logs/_search?pretty" -H 'Content-Type: application/json' -d '{
  "query": { "term": { "user": "daniel" } },
  "sort": [{ "timestamp": "desc" }],
  "_source": ["timestamp","user","action","product","status_code","duration_ms"]
}'

# Errors only
curl -s "http://localhost:9200/student_logs/_search?pretty" -H 'Content-Type: application/json' -d '{
  "query": { "range": { "status_code": { "gte": 400 } } }
}'

# Aggregation: actions by user
curl -s "http://localhost:9200/student_logs/_search?pretty" -H 'Content-Type: application/json' -d '{
  "size": 0,
  "aggs": {
    "by_user": { "terms": { "field": "user" }, "aggs": { "by_action": { "terms": { "field": "action" } } } }
  }
}'
