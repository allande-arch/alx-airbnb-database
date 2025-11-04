
---

# Task 5: Partitioning – `partitioning.sql`

```sql
-- database-adv-script/partitioning.sql
-- Partition bookings by year of check_in_date

ALTER TABLE bookings
PARTITION BY RANGE (YEAR(check_in_date)) (
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p2026 VALUES LESS THAN (2027),
    PARTITION p2027 VALUES LESS THAN (2028),
    PARTITION p_future VALUES LESS THAN (MAXVALUE)
);

-- Rebuild indexes on partitioned table
ALTER TABLE bookings DROP INDEX idx_bookings_dates;
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);