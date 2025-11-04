-- database-adv-script/joins_queries.sql
USE airbnb_db;

-- 1. INNER JOIN: All bookings with guest details
SELECT
    b.booking_id,
    b.check_in_date,
    b.check_out_date,
    b.total_price,
    u.user_id AS guest_id,
    u.first_name,
    u.last_name,
    u.email
FROM bookings b
INNER JOIN users u ON b.guest_id = u.user_id
ORDER BY b.booking_id;

-- 2. LEFT JOIN: All properties with reviews (including no reviews)
SELECT
    p.property_id,
    p.title,
    p.city_id,
    r.review_id,
    r.rating,
    r.comment
FROM properties p
LEFT JOIN bookings b ON p.property_id = b.property_id
LEFT JOIN reviews r ON b.booking_id = r.booking_id
ORDER BY p.property_id, r.review_id;

-- 3. FULL OUTER JOIN: All users and all bookings (emulated in MySQL)
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.check_in_date,
    b.status
FROM users u
LEFT JOIN bookings b ON u.user_id = b.guest_id
UNION
SELECT
    u.user_id,
    u.first_name,
    u.last_name,
    b.booking_id,
    b.check_in_date,
    b.status
FROM bookings b
LEFT JOIN users u ON b.guest_id = u.user_id
WHERE u.user_id IS NULL
ORDER BY user_id, booking_id;