# Day 6 - Clicked Vs Non-Clicked Search Results

## Problem
Calculate two percentages from search result records:
1. Percentage of records where a search result was **clicked** in the top 3 positions
2. Percentage of records where a search result was **not clicked** in the top 3 positions

Both percentages are calculated with respect to the **total number of records** and should be output in the same row as two separate columns.

---

## Solution
```sql
SELECT
    ROUND(
        100.0 * SUM(
            CASE
                WHEN clicked = 1
                     AND search_results_position <= 3
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS clicked_top_3_pct,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN clicked = 0
                     AND search_results_position <= 3
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS unclicked_top_3_pct

FROM fb_search_events;
```

---

## Approach
1. Use `CASE WHEN` inside `SUM()` to count only rows matching each condition
2. Condition 1 — clicked = 1 AND position <= 3 → clicked in top 3
3. Condition 2 — clicked = 0 AND position <= 3 → not clicked in top 3
4. Divide each count by `COUNT(*)` to get proportion over total records
5. Multiply by `100.0` to convert to percentage
6. Wrap in `ROUND(..., 2)` to get 2 decimal places
7. Both columns output in the same single row

---

## Key Concepts
- `CASE WHEN` inside `SUM()` — conditional counting
- `COUNT(*)` — total number of rows as denominator
- `ROUND()` — control decimal precision
- Conditional Aggregation — multiple metrics in one query without subqueries
- No `GROUP BY` needed — single row output across all records

---

## Learning
- Why `100.0` instead of `100` — using `100` causes integer division and returns 0; `100.0` forces float division
- `CASE WHEN ... THEN 1 ELSE 0 END` inside `SUM()` is equivalent to `COUNT IF` in other languages
- Both percentages use the same denominator `COUNT(*)` — total records not just top 3
- This pattern (conditional SUM / total COUNT) is one of the most common SQL interview patterns
- Difference from `AVG(clicked)` — AVG only works for clicked column, this approach handles any multi-condition logic
