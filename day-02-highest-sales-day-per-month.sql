-- Day 2 - Highest Sales Day per Month

CREATE TABLE sales (
    product_id VARCHAR(10),
    sale_date DATETIME,
    amount INT
);

INSERT INTO sales VALUES
('P1', '2024-01-01 10:00:00', 100),
('P2', '2024-01-01 12:00:00', 200),
('P1', '2024-01-02 09:00:00', 300),
('P3', '2024-01-03 11:00:00', 400),

('P1', '2024-02-01 10:00:00', 250),
('P2', '2024-02-01 12:00:00', 300),
('P3', '2024-02-03 15:00:00', 500),

('P1', '2024-03-01 10:00:00', 200),
('P2', '2024-03-02 14:00:00', 600),
('P3', '2024-03-03 16:00:00', 150);

WITH daily_sales AS (
    SELECT 
        CAST(sale_date AS DATE) AS day,
        DATEFROMPARTS(YEAR(sale_date), MONTH(sale_date), 1) AS month,
        SUM(amount) AS total_amount
    FROM sales
    GROUP BY 
        CAST(sale_date AS DATE),
        DATEFROMPARTS(YEAR(sale_date), MONTH(sale_date), 1)
),
ranked_sales AS (
    SELECT 
        day,
        month,
        total_amount,
        RANK() OVER (
            PARTITION BY month
            ORDER BY total_amount DESC
        ) AS rn
    FROM daily_sales
)
SELECT 
    month,
    day,
    total_amount
FROM ranked_sales
WHERE rn = 1;
