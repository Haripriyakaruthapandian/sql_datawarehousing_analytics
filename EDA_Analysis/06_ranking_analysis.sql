/*
==========================================================================
--------------------------------------------------------------------------
							06 RANKING ANALYSIS
--------------------------------------------------------------------------

Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY

==========================================================================
select top 5 * from gold.DIM_PRODUCTS;

select top 5 * from gold.fact_sales;



*/

--WHICH TOP 5 PRODUCT GENERATE HIGHEST REVENUE--
SELECT TOP 5
p.product_name as Product,
sum(s.sales_amount) as Total_Revenue
from gold.fact_sales s LEFT JOIN 
gold.dim_products p ON 
s.product_key=p.product_key
GROUP BY P.product_name
ORDER BY Total_Revenue desc;

--WHICH 5 PRODUCT PERFORMING WORST IN TERMS OF SALES--
SELECT TOP 5
p.product_name as Product,
sum(s.sales_amount) as Total_Revenue
from gold.fact_sales s LEFT JOIN 
gold.dim_products p ON 
s.product_key=p.product_key
GROUP BY P.product_name
ORDER BY Total_Revenue ASC;

----WHICH TOP 5 SUBCATEGORY GENERATE HIGHEST REVENUE--
SELECT TOP 5
p.sub_category as SubCategory,
sum(s.sales_amount) as Total_Revenue
from gold.fact_sales s LEFT JOIN 
gold.dim_products p ON 
s.product_key=p.product_key
GROUP BY p.sub_category
ORDER BY Total_Revenue DESC;

--WHICH 5 SUB CATEGORY PERFORMING WORST IN TERMS OF SALES--
SELECT TOP 5
p.sub_category as SubCategory,
sum(s.sales_amount) as Total_Revenue
from gold.fact_sales s LEFT JOIN 
gold.dim_products p ON 
s.product_key=p.product_key
GROUP BY p.sub_category
ORDER BY Total_Revenue ASC;

--ADD RANK FOR PRODUCTS(EACH PRODUCT) BASED ON TOTAL REVENUE--
SELECT 
p.product_name as Product,
sum(s.sales_amount) as Total_Revenue,
RANK() OVER(order by sum(s.sales_amount) DESC) as RANK
from gold.fact_sales s LEFT JOIN 
gold.dim_products p ON 
s.product_key=p.product_key
GROUP BY P.product_name
ORDER BY RANK ASC;

--TOP 10 CUSTOMERS WHO GENERATED HIGHEST REVENUE--
SELECT top 10 c.customer_key as Customer_id,c.first_name as First_name,
c.last_name as Last_name,sum(s.sales_amount) as Total_Revenue,
rank() OVER(ORDER BY SUM(s.sales_amount) desc) as Rank
from gold.fact_sales s LEFT JOIN 
GOLD.dim_customers c on
s.customer_key=c.customer_key
GROUP BY c.customer_key,
c.first_name,
c.last_name
ORDER BY Total_Revenue desc;

--FIND THE 3 CUSTOMERS WITH THE FEWEST ORDERS PLACED--
SELECT top 3 
c.customer_key as Customer_id,c.first_name as First_name,
c.last_name as Last_name,
COUNT(DISTINCT s.order_number) as Total_orders
from gold.fact_sales s LEFT JOIN 
GOLD.dim_customers c on
s.customer_key=c.customer_key
GROUP BY c.customer_key,
c.first_name,
c.last_name
ORDER BY Total_orders asc;