-- database-adv-script/subqueries.sql
USE airbnb_db;

-- 1. Non-correlated: Properties with average rating > 4.0
SELECT
    p.property_id,
    p.title,
    AVG(r.rating) AS avg_rating
FROM properties p
JOIN bookings b ON p.property_id = b.property_id
JOIN reviews r ON b.booking_id = r.booking_id
GROUP BY p.property_id, p.title
HAVING AVG(r.rating) > 4.0;

-- 2. Correlated: Users with more than 3 bookings
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    u.email
FROM users u
WHERE (
    SELECT COUNT(*)
    FROM bookings b
    WHERE b.guest_id = u.user_id
) > 3;