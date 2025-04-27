
/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

--CALCUTATE THE TOTAL SALES PER MONTH AND THE RUNNING TOTAL OF SALES OVER TIME--

--using aggregate function--
SELECT 
DATETRUNC(YEAR,order_date) as Order_Year,
SUM(sales_amount) AS Total_sales
FROM 
GOLD.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date) 
ORDER BY Total_sales;


--ADDING EACH ROW'S VALUE TO THE SUM OF ALL PREVIOUS ROWS VALUES--
--using windows function by year--
SELECT
order_date,
SUM(sales) OVER(ORDER BY order_date) as Total_sales
FROM(
SELECT 
DATETRUNC(YEAR,order_date) AS order_date,
SUM(sales_amount) AS sales 
FROM 
GOLD.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
)t;

--using windows function by month--
SELECT
order_date,
SUM(sales) OVER(ORDER BY order_date) as Total_sales
FROM(
SELECT 
DATETRUNC(MONTH,order_date) AS order_date,
SUM(sales_amount) AS sales 
FROM 
GOLD.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
)t;

SELECT
order_date,
SUM(sales) OVER(ORDER BY order_date) as Total_sales,
AVG(price) OVER(ORDER BY order_date) as avg_price
FROM(
SELECT 
DATETRUNC(MONTH,order_date) AS order_date,
SUM(sales_amount) AS sales,
AVG(price) AS price
FROM 
GOLD.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
)t;

SELECT
order_date,
SUM(sales) OVER(ORDER BY order_date) as Total_sales,
AVG(price) OVER(ORDER BY order_date) as avg_price
FROM(
SELECT 
DATETRUNC(YEAR,order_date) AS order_date,
SUM(sales_amount) AS sales,
AVG(price) AS price
FROM 
GOLD.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(YEAR,order_date)
)t;