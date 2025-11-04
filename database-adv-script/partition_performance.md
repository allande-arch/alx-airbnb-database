# Partitioning Performance Report

## Before Partitioning
```sql
EXPLAIN SELECT * FROM bookings WHERE check_in_date BETWEEN '2025-12-01' AND '2025-12-31';
-- Rows: 1.5M, Full scan

EXPLAIN SELECT * FROM bookings WHERE check_in_date BETWEEN '2025-12-01' AND '2025-12-31';
-- Using partition p2025 only → 180K rows