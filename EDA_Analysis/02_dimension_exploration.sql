/*
==============================================================================================
----------------------------------------------------------------------------------------------
								02. DIMENSION EXPLORATION
----------------------------------------------------------------------------------------------
Purpose:
		To explore the structure of dimension table(Customers & Products)

Functions Used:
		-DISTINCT
		-ORDER BY

==============================================================================================
select top 5 * from gold.dim_customers;
select top 5 * from gold.dim_products;

*/
--EXPLORE ALL COUNTRIES OUR CUSTOMER COMES FROM--
------------------------------------------------------------
SELECT DISTINCT country as Country from gold.dim_customers;

--EXPLORE ALL CATEGORIES "THE MAJOR DIVISIONS--
SELECT DISTINCT category as Category from gold.dim_products;

SELECT DISTINCT category,sub_category,product_name from gold.dim_products order by 1,2,3 asc;