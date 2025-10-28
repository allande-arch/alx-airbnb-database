-- =============================================
-- Airbnb Database - Seed Data
-- Task 3: Populate with Realistic Sample Data
-- File: database-script-0x02/seed.sql
-- =============================================

-- Ensure we're using the correct database
USE airbnb_db;

-- Disable foreign key checks temporarily for bulk insert
SET FOREIGN_KEY_CHECKS = 0;

-- =============================================
-- 1. Insert Users (Hosts & Guests)
-- =============================================
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
('user-001', 'Alice', 'Johnson', 'alice.johnson@example.com', 'hashed_password_1', '+1234567890', 'host', '2025-01-15 10:00:00'),
('user-002', 'Bob', 'Smith', 'bob.smith@example.com', 'hashed_password_2', '+1987654321', 'host', '2025-01-16 14:30:00'),
('user-003', 'Emma', 'Davis', 'emma.davis@example.com', 'hashed_password_3', '+1122334455', 'guest', '2025-02-01 09:15:00'),
('user-004', 'Liam', 'Wilson', 'liam.wilson@example.com', 'hashed_password_4', '+1555666777', 'guest', '2025-02-05 11:20:00'),
('user-005', 'Sophia', 'Martinez', 'sophia.m@example.com', 'hashed_password_5', '+1444333222', 'guest', '2025-02-10 16:45:00'),
('user-006', 'James', 'Brown', 'james.brown@example.com', 'hashed_password_6', '+1999888777', 'admin', '2025-01-10 08:00:00');

-- =============================================
-- 2. Insert Properties (Hosted by user-001 and user-002)
-- =============================================
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
('prop-001', 'user-001', 'Cozy Downtown Studio', 'Modern studio with city views, WiFi, kitchenette.', 'New York, NY', 120.00, '2025-01-20 12:00:00', '2025-01-20 12:00:00'),
('prop-002', 'user-001', 'Beachfront Villa', 'Luxury 3-bed villa with pool and ocean access.', 'Miami, FL', 450.00, '2025-01-22 15:30:00', '2025-01-22 15:30:00'),
('prop-003', 'user-002', 'Mountain Cabin', 'Rustic cabin with fireplace and hiking trails nearby.', 'Aspen, CO', 280.00, '2025-01-25 09:00:00', '2025-01-25 09:00:00'),
('prop-004', 'user-002', 'Urban Loft', 'Stylish loft in arts district, rooftop access.', 'Los Angeles, CA', 195.00, '2025-02-01 11:00:00', '2025-02-01 11:00:00');

-- =============================================
-- 3. Insert Bookings
-- =============================================
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
('book-001', 'prop-001', 'user-003', '2025-03-10', '2025-03-15', 600.00, 'confirmed', '2025-02-20 10:30:00'),
('book-002', 'prop-002', 'user-004', '2025-04-01', '2025-04-07', 3150.00, 'confirmed', '2025-02-25 14:15:00'),
('book-003', 'prop-003', 'user-005', '2025-05-20', '2025-05-23', 840.00, 'pending', '2025-03-01 09:00:00'),
('book-004', 'prop-001', 'user-005', '2025-06-05', '2025-06-08', 360.00, 'canceled', '2025-03-10 16:20:00'),
('book-005', 'prop-004', 'user-003', '2025-07-12', '2025-07-15', 585.00, 'confirmed', '2025-03-15 11:45:00');

-- =============================================
-- 4. Insert Payments (One per confirmed/paid booking)
-- =============================================
INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('pay-001', 'book-001', 600.00, '2025-02-21 08:00:00', 'credit_card'),
('pay-002', 'book-002', 3150.00, '2025-02-26 10:30:00', 'paypal'),
('pay-003', 'book-005', 585.00, '2025-03-16 09:15:00', 'stripe');

-- =============================================
-- 5. Insert Reviews (Only for completed stays)
-- =============================================
INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
('rev-001', 'prop-001', 'user-003', 5, 'Amazing location and super clean! Host was very responsive.', '2025-03-16 14:00:00'),
('rev-002', 'prop-002', 'user-004', 4, 'Beautiful villa, but WiFi was slow at times.', '2025-04-08 11:30:00'),
('rev-003', 'prop-004', 'user-003', 5, 'Loved the rooftop! Will book again.', '2025-07-16 10:00:00');

-- =============================================
-- 6. Insert Messages (Between users)
-- =============================================
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
('msg-001', 'user-003', 'user-001', 'Hi Alice, is the studio available from March 10-15?', '2025-02-18 09:00:00'),
('msg-002', 'user-001', 'user-003', 'Yes! It’s available. I’ll send you the details.', '2025-02-18 09:15:00'),
('msg-003', 'user-004', 'user-001', 'Can we check in early on April 1?', '2025-02-24 12:00:00'),
('msg-004', 'user-001', 'user-004', 'Early check-in is possible after 12 PM for $50.', '2025-02-24 12:30:00'),
('msg-005', 'user-005', 'user-002', 'Is the cabin pet-friendly?', '2025-02-28 15:00:00'),
('msg-006', 'user-002', 'user-005', 'Sorry, no pets allowed.', '2025-02-28 15:20:00');

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- =============================================
-- Verification Queries (Optional - Run to check)
-- =============================================
-- SELECT 'Users' AS Table, COUNT(*) AS Count FROM User
-- UNION ALL SELECT 'Properties', COUNT(*) FROM Property
-- UNION ALL SELECT 'Bookings', COUNT(*) FROM Booking
-- UNION ALL SELECT 'Payments', COUNT(*) FROM Payment
-- UNION ALL SELECT 'Reviews', COUNT(*) FROM Review
-- UNION ALL SELECT 'Messages', COUNT(*) FROM Message;