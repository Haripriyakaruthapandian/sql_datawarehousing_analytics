
/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions
SELECT 
YEAR(order_date) as Order_year,
MONTH(order_date) as Order_Month,
SUM(sales_amount) as Total_sales,
COUNT(DISTINCT(customer_key)) as Total_Customers,
SUM(QUANTITY) AS Total_quantity
FROM GOLD.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY Order_year,Order_Month
;


SELECT 
MONTH(order_date) as Order_month,
SUM(sales_amount) as Total_sales,
COUNT(DISTINCT(customer_key)) as Total_Customers,
SUM(QUANTITY) AS Total_quantity
FROM GOLD.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY Order_month
;

SELECT 
FORMAT(order_date,'yyyy-MMM') as Order_Year,
SUM(sales_amount) as Total_sales,
COUNT(DISTINCT(customer_key)) as Total_Customers,
SUM(QUANTITY) AS Total_quantity
FROM GOLD.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date,'yyyy-MMM')
ORDER BY FORMAT(order_date,'yyyy-MMM')
;
SELECT 
DATETRUNC(MONTH,order_date) as Order_Month,
SUM(sales_amount) as Total_sales,
COUNT(DISTINCT(customer_key)) as Total_Customers,
SUM(QUANTITY) AS Total_quantity
FROM GOLD.fact_sales 
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(MONTH,order_date)
ORDER BY DATETRUNC(MONTH,order_date)
;