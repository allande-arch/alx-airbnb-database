# Airbnb Database - Seed Data  
**Task 3: Populate Database with Sample Data**  
**Directory:** `database-script-0x02/`  
**File:** `seed.sql`

---

## Overview

This script inserts **realistic, interconnected sample data** into the Airbnb database, simulating real-world usage across all 6 tables.

---

## Data Summary

| Table       | Records | Notes |
|-------------|--------|-------|
| `User`      | 6      | 2 hosts, 3 guests, 1 admin |
| `Property`  | 4      | Varied locations & prices |
| `Booking`   | 5      | Confirmed, pending, canceled |
| `Payment`   | 3      | One per confirmed booking |
| `Review`    | 3      | Only for completed stays |
| `Message`   | 6      | Conversations between users |

---

## Key Features

- **UUIDs** used as `CHAR(36)` (application-style)
- **Realistic timelines** (bookings in future, reviews after stay)
- **Data consistency** via foreign keys
- **Varied statuses** (`pending`, `confirmed`, `canceled`)
- **Payment methods** diversified
- **Natural message threads**

---

## How to Run

```bash
# After running schema.sql
mysql -u root -p airbnb_db < database-script-0x02/seed.sql