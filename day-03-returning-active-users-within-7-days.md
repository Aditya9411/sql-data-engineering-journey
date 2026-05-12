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
