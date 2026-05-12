# Day 03 - Returning Active Users (1 to 7 Days)

## Problem Statement

Find users who made a **second purchase within 1 to 7 days** after their first purchase.

- Ignore same-day purchases
- Return unique user_id list

---

## Dataset

Table: `amazon_transactions`

| Column | Description |
|---|---|
| user_id | Unique user identifier |
| created_at | Purchase date |
| id | Transaction ID |
| item | Item purchased |
| revenue | Revenue generated |

---

## Goal

Identify users who **returned and made another purchase within 1–7 days** after their first purchase.

---

## Approach

We solve this in 4 steps:

1. Find first purchase per user
2. Use CTE to store first purchase dates
3. Join with original table
4. Filter by 1–7 day difference

---

## Step 1: First Purchase per User

```sql
SELECT 
    user_id,
    MIN(created_at) AS first_purchase_date
FROM amazon_transactions
GROUP BY user_id;
```

---

## Step 2: Use CTE (First Purchase Table)

```sql
WITH first_purchase AS (
    SELECT 
        user_id,
        MIN(created_at) AS first_purchase_date
    FROM amazon_transactions
    GROUP BY user_id
)
```

---

## Step 3: Join with Original Table

```sql
FROM amazon_transactions a
JOIN first_purchase f
    ON a.user_id = f.user_id
```

---

## Step 4: Calculate Date Difference (PostgreSQL)

```sql
a.created_at - f.first_purchase_date
```

**Example:**
```
2024-01-05 - 2024-01-01 = 4 days ✅
2024-01-01 - 2024-01-01 = 0 days ❌ (same day, excluded)
```

---

## Step 5: Apply Filter (1 to 7 Days)

```sql
WHERE (a.created_at - f.first_purchase_date) BETWEEN 1 AND 7
```

- Excludes same-day purchases (0 days)
- Keeps only 1–7 day returns

---

## Final Query

```sql
-- Day 03: Returning Active Users
-- Find users who made a second purchase within 1–7 days after their first

WITH first_purchase AS (
    SELECT 
        user_id,
        MIN(created_at) AS first_purchase_date
    FROM amazon_transactions
    GROUP BY user_id
)

SELECT DISTINCT a.user_id
FROM amazon_transactions a
JOIN first_purchase f
    ON a.user_id = f.user_id
WHERE (a.created_at - f.first_purchase_date) BETWEEN 1 AND 7
ORDER BY a.user_id;
```

---

## Output

List of unique `user_id` values who made a second purchase within 1–7 days after their first purchase.

---

## Key Concepts Used

| Concept | Usage |
|---|---|
| `GROUP BY` | Group transactions per user |
| `MIN()` | Get earliest purchase date |
| `CTE (WITH)` | Store intermediate result |
| `JOIN` | Compare all purchases with first purchase |
| `DISTINCT` | Remove duplicate user_ids |
| Date difference | PostgreSQL date arithmetic |

---

## Pattern to Remember

```
First Event → Compare Future Events → Filter by Time Window
```

---

## Interview Shortcut

Whenever you see keywords like:
- **Returning users**
- **Repeat purchases**
- **Retention**
- **User comeback**

Think:

```
MIN() + JOIN + DATE DIFFERENCE
```
