# elk-student-logs-lab

A minimal, ready-to-run **ELK** lab that ingests demo events into an index called `student_logs`, so you can explore them in **Kibana**.

## What’s inside
- `docker-compose.yml` — Elasticsearch + Kibana (single-node, security disabled for lab)
- `scripts/generate_advanced_logs.sh` — generates 50 demo events with a basic mapping
- `scripts/stream_logs.sh` — optional continuous log streamer (Ctrl+C to stop)
- `scripts/curl-cheats.sh` — quick `_health`, `_count`, searches and aggregations
- `kibana/` — placeholder for Kibana saved objects (NDJSON) if you export/import

## Prerequisites
- Docker & Docker Compose
- `curl`

## Quick start
```bash
docker compose up -d
curl -s http://localhost:9200/_cluster/health?pretty


Generate demo data
chmod +x scripts/generate_advanced_logs.sh
./scripts/generate_advanced_logs.sh       # default: 50 events into student_logs

# (optional) continuous stream
chmod +x scripts/stream_logs.sh
./scripts/stream_logs.s


Kibana

Open: http://localhost:5601

Create a Data View: student_logs* (time field: timestamp)

Try simple visuals:

Bar: actions/users

Pie: products

Metric: errors (status_code >= 400)

Line: avg duration_ms

Build a dashboard; export your saved objects (NDJSON) into kibana/ if you like.


Quick checks
./scripts/curl-cheats.sh


Cleanup / Reset
# reset data only
curl -X DELETE http://localhost:9200/student_logs

# stop stack
docker compose down -v


Notes

Security is disabled for simplicity; enable xpack when needed.

You can override defaults via env vars:

generator: ES_URL, INDEX, COUNT

streamer: INDEX, INTERVAL


