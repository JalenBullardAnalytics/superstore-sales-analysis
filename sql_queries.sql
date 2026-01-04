/* ------------------------------------------------------------
   Superstore Sales Performance Analysis
   Author: Jalen Bullard
   Date: Jan 2026
   Notes:
   - Queries assume a table named: superstore
   - Key fields used: order_date, region, category, sales, profit
   - The monthly trend query uses PostgreSQL syntax (TO_CHAR).
     If you're using MySQL/SQLite, see the alternatives below.
------------------------------------------------------------ */

-- 1) Total Sales by Region
SELECT
    region,
    SUM(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- 2) Total Profit by Category
SELECT
    category,
    SUM(profit) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_profit DESC;

-- 3) Average Profit per Order (by Category)
SELECT
    category,
    AVG(profit) AS avg_profit_per_order
FROM superstore
WHERE profit IS NOT NULL
GROUP BY category
ORDER BY avg_profit_per_order DESC;

-- 4) Monthly Sales Trend (PostgreSQL)
-- Groups sales by month (YYYY-MM) to identify trends/seasonality
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    SUM(sales) AS total_sales_by_month
FROM superstore
WHERE order_date IS NOT NULL
  AND sales IS NOT NULL
GROUP BY TO_CHAR(order_date, 'YYYY-MM')
ORDER BY month;

-- 5) Regions with Negative Profit (Total Loss)
-- Identifies regions generating overall losses (profit < 0)
SELECT
    region,
    SUM(profit) AS total_loss
FROM superstore
WHERE profit < 0
GROUP BY region
ORDER BY total_loss ASC;

-- 6) Sales vs Profit by Region
-- Compares total sales and total profit to spot efficiency differences
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM superstore
WHERE sales IS NOT NULL
  AND profit IS NOT NULL
GROUP BY region
ORDER BY total_sales DESC;
