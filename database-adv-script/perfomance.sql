
---

# Task 4: Query Optimization – `perfomance.sql`

```sql
-- database-adv-script/perfomance.sql
-- INITIAL SLOW QUERY (to be optimized)
EXPLAIN
SELECT
    b.booking_id,
    u.first_name AS guest_name,
    p.title AS property_title,
    c.name AS city,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    r.rating
FROM bookings b
JOIN users u ON b.guest_id = u.user_id
JOIN properties p ON b.property_id = p.property_id
JOIN cities c ON p.city_id = c.city_id
LEFT JOIN reviews r ON b.booking_id = r.booking_id
WHERE b.check_in_date >= '2025-12-01'
  AND p.price_per_night <= 300
ORDER BY b.total_price DESC;