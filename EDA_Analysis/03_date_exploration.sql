/*
==========================================================================================
------------------------------------------------------------------------------------------
							03.DATE EXPLORATION
------------------------------------------------------------------------------------------
Purpose:
	1.To understand the temporal boundaries of key data points.
	2.To understand the range of historical data.

Functions used:
	1.MIN()
	2.MAX()
	3.DATEDIFF()

select top 5 * from gold.dim_customers;
select top 5 * from gold.dim_products;
===========================================================================================
*/

--IDENTIFY THE EARLIEST AND LATEST BIRTHDATES(BOUNDARIES)--
SELECT MIN(birthdate) as Earliest_Birthdates, MAX(birthdate) as Latest_Birthdates 
from gold.dim_customers;

---FIND THE DATE OF THE FIRST AND LAST ORDERS---
SELECT MIN(order_date) as FIRST_ORDER, MAX(order_date) AS LAST_ORDER 
FROM gold.fact_sales;


---FIND THE DATE OF THE FIRST AND LAST ORDERS AND THE TOTAL DURATION BETWEEN IN MONTHS---
SELECT MIN(order_date) as FIRST_ORDER, MAX(order_date) AS LAST_ORDER,
DATEDIFF(MONTH,MIN(order_date),MAX(order_date))as Total_duration_in_months
FROM gold.fact_sales;

---FIND THE DATE OF THE FIRST AND LAST ORDERS AND THE TOTAL DURATION BETWEEN IN YEAR---
SELECT MIN(order_date) as FIRST_ORDER, MAX(order_date) AS LAST_ORDER,
DATEDIFF(YEAR,MIN(order_date),MAX(order_date))as Total_duration_in_years
FROM gold.fact_sales;

--FIND THE YOUNGEST AND OLDEST CUSTOMERS--
SELECT MIN(birthdate) AS OLDEST_birthdate,
DATEDIFF(year,MIN(birthdate),GETDATE())as Oldest_age,
MAX(birthdate) as Youngest_birthdate,
DATEDIFF(year,MAX(birthdate),GETDATE())as youngest_age
from gold.dim_customers;