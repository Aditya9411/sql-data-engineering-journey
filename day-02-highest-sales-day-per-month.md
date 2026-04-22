# Day 2 - Highest Sales Day per Month

## Problem
Find the day with the highest total sales in each month.

---

## Approach

1. Convert datetime to date using CAST
2. Extract month using DATEFROMPARTS
3. Aggregate daily sales using SUM
4. Rank days within each month using RANK()
5. Filter top result using rn = 1

---

## Key Concepts

- GROUP BY
- Aggregation (SUM)
- Window Functions (RANK)
- Date Handling in SQL Server

---

## Learning

- Why we remove time using CAST
- Difference between RANK and DENSE_RANK
- How to group by month properly
