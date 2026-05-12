# Day 03 - Returning Active Users (1 to 7 Days)

## Problem Statement
Find users who made a **second purchase within 1 to 7 days** after their first purchase.

- Ignore same-day purchases
- Return unique user_id list

---

## Dataset
Table: `amazon_transactions`

Columns:
- user_id
- created_at
- id
- item
- revenue

---

## Goal
Identify users who **returned and made another purchase within 1–7 days** after their first purchase.

---

## Approach

We solve this in 3 steps:

### Step 1: Find first purchase per user
### Step 2: Compare all purchases with first purchase
### Step 3: Filter by 1–7 day difference

---

## Step 1: First Purchase per User

```sql
SELECT 
    user_id,
    MIN(created_at) AS first_purchase_date
FROM amazon_transactions
GROUP BY user_id;

### Step 2: Use CTE (First Purchase Table)
WITH first_purchase AS (
    SELECT 
        user_id,
        MIN(created_at) AS first_purchase_date
    FROM amazon_transactions
    GROUP BY user_id
)
###Step 3: Join with Original Table
FROM amazon_transactions a
JOIN first_purchase f
    ON a.user_id = f.user_id
Step 4: Calculate Date Difference (PostgreSQL)
a.created_at - f.first_purchase_date

Example:

2024-01-05 - 2024-01-01 = 4 days
Step 5: Apply Filter (1 to 7 Days)
WHERE (a.created_at - f.first_purchase_date) BETWEEN 1 AND 7
Excludes same-day purchases (0 days)
Keeps only 1–7 day returns
Final Query
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
Output

List of users who made a second purchase within 1–7 days after their first purchase.

Key Concepts Used
GROUP BY
MIN()
CTE (WITH clause)
JOIN
DISTINCT
Date difference in PostgreSQL
Pattern to Remember
First Event → Compare Future Events → Filter by Time Window
Interview Shortcut

Whenever you see:

Returning users
Repeat purchases
Retention
User comeback

Think:

MIN() + JOIN + DATE DIFFERENCE
