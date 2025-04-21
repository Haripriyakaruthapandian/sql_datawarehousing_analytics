/*
==================================================================================
----------------------------------------------------------------------------------
							04_MEASURE_EXPLORATION
----------------------------------------------------------------------------------

Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
==================================================================================




SELECT TOP 5 * FROM GOLD.FACT_SALES;
*/
----FIND TOTAL SALES--------
SELECT SUM(sales_amount) as Total_Sales from gold.fact_sales;

--FIND HOW MANY ITEMS ARE SOLD--
SELECT SUM(quantity) as TOTAL_ITEMS FROM gold.fact_sales;

--FIND THE AVERAGE OF SELLING PRICE--
SELECT AVG(sales_amount) as Avg_Selling_price FROM gold.fact_sales;

--FIND THE TOTAL NUMBER OF ORDERS--
SELECT COUNT(DISTINCT order_number) as Total_Orders from gold.fact_sales;

--FIND THE TOTAL NUMBER OF PRODUCTS--
SELECT COUNT(DISTINCT product_key) as Total_Products from gold.fact_sales;

--FIND TOTAL NUMBER OF CUSTOMERS--
SELECT COUNT(customer_key) as Total_Customers from gold.fact_sales;

--FIND TOTAL NUMBER OF CUSTOMERS PLACED AN ORDER---
SELECT COUNT(DISTINCT customer_key) as Total_Customers_Placed_Order FROM gold.fact_sales;  --Removes Duplicates ordered by customers and shows distinct --


--GENERATE REPORTS THAT SHOWS ALL KEY METRICS OF THE BUSINESS--
SELECT 'TOTAL SALES' AS MEASURE_NAME,SUM(sales_amount) as Measure_Value from gold.fact_sales
UNION ALL
SELECT 'TOTAL ITEMS' AS MEASURE_NAME,SUM(quantity) as Measure_Value from gold.fact_sales
UNION ALL
SELECT 'AVG SALES' AS MEASURE_NAME,AVG(sales_amount) as Measure_Value from gold.fact_sales
UNION ALL
SELECT 'TOTAL ORDERS' AS MEASURE_NAME,COUNT(DISTINCT order_number) as Measure_Value from gold.fact_sales
UNION ALL
SELECT 'TOTAL PRODUCTS' AS MEASURE_NAME,COUNT(DISTINCT product_key) as Measure_Value from gold.fact_sales
UNION ALL
SELECT 'TOTAL CUSTOMERS' AS MEASURE_NAME,COUNT(customer_key) as Measure_Value from gold.fact_sales
UNION ALL
SELECT 'TOTAL_CUSTOMERS_PLACED_ORDERS' AS MEASURE_NAME,COUNT(DISTINCT customer_key) as Measure_Value from gold.fact_sales
;
