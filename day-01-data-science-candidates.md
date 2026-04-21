# Day 1 - Find Candidates with Required Skills

## Problem
Given a table of candidates and their skills, find candidates who have all required skills:
- Python
- Tableau
- PostgreSQL

Return the result sorted by candidate_id.

## Table Schema
**candidates**
- candidate_id (int)
- skill (varchar)

## Business Use Case
A company is hiring for a Data Science role and wants to shortlist candidates who have all the required technical skills.

## SQL Solution

```sql
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;
## Explanation

- We first filter only the required skills (Python, Tableau, PostgreSQL)
- Then group by candidate_id
- Count how many required skills each candidate has
- If count = 3 → candidate has all required skills

## Interview Tip

Use COUNT(DISTINCT skill) to handle duplicates safely:

```sql
HAVING COUNT(DISTINCT skill) = 3
