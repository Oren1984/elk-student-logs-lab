# elk-student-logs-lab

A minimal, **ready-to-run** ELK lab for demo logs (`student_logs`).

## 0) Prerequisites
- Docker & Docker Compose
- `curl`

## 1) Start the stack
```bash
docker compose up -d
curl -s http://localhost:9200/_cluster/health?pretty
```

## 2) Generate demo data
```bash
chmod +x scripts/generate_advanced_logs.sh
./scripts/generate_advanced_logs.sh   # default: 50 events
```

Optional continuous stream:
```bash
chmod +x scripts/stream_logs.sh
./scripts/stream_logs.sh
```

## 3) Quick checks
```bash
./scripts/curl-cheats.sh
```

## 4) Kibana
- http://localhost:5601
- Data View: `student_logs*` (time field: `timestamp`)
- Build simple visualizations and a dashboard (Bar/Pie/Metric/Line).

## 5) Cleanup
```bash
curl -X DELETE http://localhost:9200/student_logs
docker compose down -v
```

> Security disabled for simplicity; enable xpack when needed.
