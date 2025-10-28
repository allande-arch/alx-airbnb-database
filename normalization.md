# Database Normalization Report - Airbnb Schema  
> **Task 1: Normalize Your Database Design**  
> **File:** `normalization.md`  
> **Objective:** Ensure the database schema is in **Third Normal Form (3NF)**

---

## Summary

After thorough analysis, the **Airbnb database schema** as defined in the specification is **already in Third Normal Form (3NF)**.  
No modifications are required. This report explains the normalization process, verifies compliance with **1NF, 2NF, and 3NF**, and highlights design decisions that ensure data integrity and efficiency.

---

## Step-by-Step Normalization Analysis

### 1. **First Normal Form (1NF)**  
> *All attributes are atomic, and there are no repeating groups.*

| Requirement | Status | Evidence |
|-----------|--------|--------|
| Atomic values only | Passed | All fields contain single values (e.g., `first_name`, `email`, `pricepernight`) |
| No repeating groups | Passed | No arrays or multi-valued attributes |
| Primary key defined | Passed | Every table has a `*_id` UUID as PK |

**All tables satisfy 1NF.**

---

### 2. **Second Normal Form (2NF)**  
> *Must be in 1NF and no partial dependency — non-key attributes depend fully on the entire primary key.*

Since **all tables use a single-column primary key (UUID)**, partial dependency is impossible.

| Table | PK | Non-key Attributes | Full Dependency? |
|------|----|---------------------|------------------|
| `User` | `user_id` | `first_name`, `email`, etc. | Yes |
| `Property` | `property_id` | `name`, `host_id`, `pricepernight` | Yes |
| `Booking` | `booking_id` | `user_id`, `property_id`, `total_price` | Yes |

**All tables satisfy 2NF.**

---

### 3. **Third Normal Form (3NF)**  
> *Must be in 2NF and no transitive dependency — non-key attributes depend only on the primary key, not on other non-key attributes.*

We now check for **transitive dependencies** (A → B → C, where C should not depend on B).

#### Analysis per Table:

| Table | Potential Transitive Dependency? | Resolution |
|------|----------------------------------|----------|
| `User` | None | All attributes (name, email, role) describe the `user_id` directly |
| `Property` | `host_id` → `host_name`? | No — host details are **not stored** in `Property`. Only `host_id` FK exists → **correct** |
| `Booking` | `property_id` → `pricepernight`? | No — `total_price` is **calculated** at booking time → stored for history & performance |
| `Payment` | `booking_id` → `user_id`? | No — `Payment` only references `booking_id`, not user directly |
| `Review` | `property_id` → `location`? | No — review only stores `rating` and `comment`, not redundant property data |

> **Key Design Decision**:  
> `total_price` in `Booking` is **intentionally denormalized slightly** for performance and auditability (common in real-world systems), but it does **not violate 3NF** because:
> - It is derived from `pricepernight × nights`, but stored to prevent recalculation errors.
> - It is **controlled by application logic**, not a transitive dependency on another non-key.

**This is acceptable** in production systems under **controlled denormalization**.

---

## Final 3NF Compliance Verification

| Table | 1NF | 2NF | 3NF | Notes |
|------|-----|-----|-----|-------|
| `User` | Yes | Yes | Yes | Clean entity |
| `Property` | Yes | Yes | Yes | Host details not duplicated |
| `Booking` | Yes | Yes | Yes | `total_price` stored for integrity |
| `Payment` | Yes | Yes | Yes | 1:1 with Booking |
| `Review` | Yes | Yes | Yes | No property data repeated |
| `Message` | Yes | Yes | Yes | Self-referencing FKs |

**All tables are in 3NF.**

---

## Normalization Benefits Achieved

| Benefit | Achieved? | How |
|-------|----------|-----|
| Eliminate redundancy | Yes | No duplicate host/property data |
| Prevent update anomalies | Yes | Change host name → only in `User` |
| Ensure data integrity | Yes | FK constraints + CHECKs |
| Support scalability | Yes | Indexed FKs, efficient joins |

---

## Optional: Boyce-Codd Normal Form (BCNF)?

While not required, let’s briefly check:

- All determinants are candidate keys.
- No overlapping candidate keys.
- No complex dependencies.

**Schema satisfies BCNF** (stronger than 3NF).

---

## Conclusion

> **The Airbnb database schema is fully normalized to 3NF (and BCNF).**  
> No changes are required.

The design eliminates redundancy, ensures data consistency, and supports efficient querying — meeting professional database standards.

---

## Files to Submit
