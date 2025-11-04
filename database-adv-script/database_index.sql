# Index Optimization Report

## High-Usage Columns Identified

| Table       | Column(s)                  | Used In         | Index Type       |
|-------------|----------------------------|-----------------|------------------|
| `users`     | `email`                    | WHERE, JOIN     | B-tree (UNIQUE)  |
| `bookings`  | `guest_id`                 | JOIN            | B-tree           |
| `bookings`  | `property_id`              | JOIN            | B-tree           |
| `bookings`  | `check_in_date`            | WHERE, RANGE    | B-tree           |
| `properties`| `city_id`                  | WHERE           | B-tree           |
| `properties`| `price_per_night`          | ORDER BY        | B-tree           |

## Index Creation Commands (`database_index.sql`)

```sql
-- Add missing indexes
CREATE INDEX idx_bookings_guest ON bookings(guest_id);
CREATE INDEX idx_bookings_property ON bookings(property_id);
CREATE INDEX idx_bookings_dates ON bookings(check_in_date, check_out_date);
CREATE INDEX idx_properties_city ON properties(city_id);
CREATE INDEX idx_properties_price ON properties(price_per_night);

-- Composite index for frequent search
CREATE INDEX idx_search ON properties(city_id, price_per_night, max_guests);




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