# Airbnb Database - Entity Relationship Diagram (ERD) Requirements

> **Task 0: Define Entities and Relationships in ER Diagram**  
> **Directory:** `ERD/`  
> **File:** `requirements.md`

---

## Objective

Design a comprehensive **Entity-Relationship Diagram (ERD)** that visually represents the database schema for an **Airbnb-like application**, based on the provided **Database Specification**.

The ERD must clearly illustrate:
- All **entities**
- Their **attributes**
- **Primary and Foreign Key relationships**
- **Cardinality** (1:1, 1:N, N:M)
- Proper use of **crow's foot notation** (recommended)

---

## Entities & Attributes

### 1. **User**
| Attribute | Type | Constraints |
|---------|------|-------------|
| `user_id` | UUID | **PK**, Indexed |
| `first_name` | VARCHAR | NOT NULL |
| `last_name` | VARCHAR | NOT NULL |
| `email` | VARCHAR | UNIQUE, NOT NULL |
| `password_hash` | VARCHAR | NOT NULL |
| `phone_number` | VARCHAR | NULL |
| `role` | ENUM('guest', 'host', 'admin') | NOT NULL |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

### 2. **Property**
| Attribute | Type | Constraints |
|---------|------|-------------|
| `property_id` | UUID | **PK**, Indexed |
| `host_id` | UUID | **FK** → `User(user_id)` |
| `name` | VARCHAR | NOT NULL |
| `description` | TEXT | NOT NULL |
| `location` | VARCHAR | NOT NULL |
| `pricepernight` | DECIMAL | NOT NULL |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| `updated_at` | TIMESTAMP | ON UPDATE CURRENT_TIMESTAMP |

---

### 3. **Booking**
| Attribute | Type | Constraints |
|---------|------|-------------|
| `booking_id` | UUID | **PK**, Indexed |
| `property_id` | UUID | **FK** → `Property(property_id)` |
| `user_id` | UUID | **FK** → `User(user_id)` |
| `start_date` | DATE | NOT NULL |
| `end_date` | DATE | NOT NULL |
| `total_price` | DECIMAL | NOT NULL |
| `status` | ENUM('pending', 'confirmed', 'canceled') | NOT NULL |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

### 4. **Payment**
| Attribute | Type | Constraints |
|---------|------|-------------|
| `payment_id` | UUID | **PK**, Indexed |
| `booking_id` | UUID | **FK** → `Booking(booking_id)` |
| `amount` | DECIMAL | NOT NULL |
| `payment_date` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |
| `payment_method` | ENUM('credit_card', 'paypal', 'stripe') | NOT NULL |

---

### 5. **Review**
| Attribute | Type | Constraints |
|---------|------|-------------|
| `review_id` | UUID | **PK**, Indexed |
| `property_id` | UUID | **FK** → `Property(property_id)` |
| `user_id` | UUID | **FK** → `User(user_id)` |
| `rating` | INTEGER | CHECK (1 ≤ rating ≤ 5), NOT NULL |
| `comment` | TEXT | NOT NULL |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

### 6. **Message**
| Attribute | Type | Constraints |
|---------|------|-------------|
| `message_id` | UUID | **PK**, Indexed |
| `sender_id` | UUID | **FK** → `User(user_id)` |
| `recipient_id` | UUID | **FK** → `User(user_id)` |
| `message_body` | TEXT | NOT NULL |
| `sent_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP |

---

## Relationships (Cardinality)

| Relationship | Type | Description |
|------------|------|-----------|
| **User → Property** | 1:N | One host owns many properties |
| **User → Booking** | 1:N | One guest makes many bookings |
| **Property → Booking** | 1:N | One property has many bookings |
| **Booking → Payment** | 1:1 | One booking has exactly one payment (assumed) |
| **Property → Review** | 1:N | One property receives many reviews |
| **User → Review** | 1:N | One user writes many reviews |
| **User → Message (sender)** | 1:N | One user sends many messages |
| **User → Message (recipient)** | 1:N | One user receives many messages |

> **Note:** `Message` involves **self-referencing** foreign keys on `User`.

---

## Indexing Strategy

| Table | Indexed Columns |
|------|-----------------|
| `User` | `user_id` (PK), `email` (UNIQUE) |
| `Property` | `property_id` (PK), `host_id` (FK) |
| `Booking` | `booking_id` (PK), `property_id`, `user_id` |
| `Payment` | `payment_id` (PK), `booking_id` |
| `Review` | `review_id` (PK), `property_id`, `user_id` |
| `Message` | `message_id` (PK), `sender_id`, `recipient_id` |

---

## ERD Diagram Requirements

Create your ERD using **[Draw.io](https://draw.io)** (or equivalent) and export as:

- `airbnb_erd.drawio` (source file)
- `airbnb_erd.png` or `airbnb_erd.pdf` (visual output)

### File Placement: