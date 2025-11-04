
---

# Task 6: Performance Monitoring – `performance_monitoring.md`

```markdown
# Database Performance Monitoring

## Tools Used
- `EXPLAIN ANALYZE` (MySQL 8.0.18+)
- `SHOW PROFILE` (deprecated, but simulated)
- `performance_schema`

## Sample Query Analysis

```sql
EXPLAIN ANALYZE
SELECT COUNT(*) FROM bookings WHERE check_in_date > '2025-01-01';

-> Filter: (bookings.check_in_date > '2025-01-01')  (cost=...)
   -> Index range scan on bookings using idx_bookings_dates