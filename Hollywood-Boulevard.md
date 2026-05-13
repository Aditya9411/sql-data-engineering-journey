# Day 5 - Lowest Score per Facility in Hollywood Boulevard

## Problem
Find the lowest inspection score for each facility located on Hollywood Boulevard.
Output the facility name along with its lowest score.
Order by lowest score descending and facility name ascending.

---

## Approach
1. Filter rows using `LIKE '%Hollywood Boulevard%'` on facility_address
2. Group rows by `facility_name`
3. Aggregate scores using `MIN()` to get lowest score per facility
4. Sort results using `ORDER BY lowest_score DESC, facility_name ASC`

---

## Solution
```sql
SELECT
    facility_name,
    MIN(score) AS lowest_score
FROM los_angeles_restaurant_health_inspections
WHERE facility_address LIKE '%Hollywood Boulevard%'
GROUP BY facility_name
ORDER BY lowest_score DESC,
         facility_name ASC;
```

---

## Key Concepts
- WHERE with LIKE — Pattern matching to filter a specific street
- GROUP BY — Group rows by each unique facility name
- Aggregation (MIN) — Find the lowest score within each group
- ORDER BY — Multi-column sorting with mixed directions

---

## Learning
- Why we use `LIKE '%Hollywood Boulevard%'` instead of exact match — addresses may have house numbers before the street name
- `MIN()` returns the single lowest value per group after GROUP BY
- `ORDER BY col1 DESC, col2 ASC` — first sort is primary, second is a tiebreaker
- Difference between `MIN()` and `RANK()` — MIN gives the value directly, RANK gives a position that needs filtering
