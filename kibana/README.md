# Kibana / Outputs Examples

This folder is intentionally empty in git (no real data).  
Below are **safe examples** showing how outputs may look.

---

## 1) Example Elasticsearch document (student_logs)

```json
{
  "timestamp": "2025-01-01T12:34:56Z",
  "user": "daniel",
  "action": "purchase",
  "product": "book",
  "status_code": 200,
  "duration_ms": 123
}
Use Discover (Kibana) or _search to view similar docs at runtime.
No real logs are stored in the repo.

2) Example Kibana Saved Objects (NDJSON)
NDJSON is a line-per-object export (Data Views, Visualizations, Dashboards).
This is a demo only snippet—do not import as-is.

ndjson
Copy code
{"type":"index-pattern","id":"student_logs","attributes":{"title":"student_logs*","timeFieldName":"timestamp"}}
{"type":"visualization","id":"vis-example","attributes":{"title":"Actions by User","visState":"{\"title\":\"Actions by User\",\"type\":\"histogram\",\"aggs\":[{\"id\":\"1\",\"type\":\"count\",\"schema\":\"metric\"},{\"id\":\"2\",\"type\":\"terms\",\"schema\":\"segment\",\"params\":{\"field\":\"user\",\"size\":5}}],\"params\":{\"addLegend\":true}}","kibanaSavedObjectMeta":{"searchSourceJSON":"{\"index\":\"student_logs\",\"query\":{\"language\":\"kuery\",\"query\":\"\"},\"filter\":[]}"}}}
If you create your own dashboards, export them from Kibana → Stack Management → Saved Objects → Export
and save the .ndjson here (not recommended for sensitive environments).

Security note
Keep real data out of git. Store only definitions or synthetic examples.

For demos, prefer screenshots or sanitized samples over full exports.
