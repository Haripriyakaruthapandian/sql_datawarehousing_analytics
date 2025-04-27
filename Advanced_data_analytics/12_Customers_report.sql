/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend


		select top 5 * from gold.dim_products;
select top 5 * from gold.fact_sales;
select top 5 * from gold.dim_customers;
===============================================================================
*/



create view customer_report as
with customer_reports as(
select
c.customer_key as customer_key,
f.product_key as product_key,
f.sales_amount as sales_amount,
f.quantity as quantity,
f.price as price,
c.first_name as first_name,
c.last_name as last_name,
c.birthdate as birthdate,
f.order_date as order_date,
f.sales_amount as total_sales,
f.order_number as order_number

from 
gold.fact_sales f left join 
gold.dim_customers c
on f.customer_key=c.customer_key
where f.order_date is not null

),
customer_aggregation as(
select customer_key,
concat(first_name,' ',last_name) as customer_name,
datediff(year,birthdate,GETDATE()) as age,
sum(sales_amount) as total_sales,
--min(order_date) as first_order,max(order_date) as last_order,
datediff(year,min(order_date),max(order_date)) as lifespan,
count(distinct product_key) as total_products,
MAX(order_date) as last_order,
count(distinct order_number) as total_orders,
sum(quantity) as total_quantity
from customer_reports
group by 
customer_key,
concat(first_name,' ',last_name),datediff(year,birthdate,GETDATE())
)
select 
customer_key,
customer_name,
case when lifespan<=12 and total_sales<5000 then 'VIP'
	 when lifespan<=12 and total_sales>=5000 then 'Regular'
	 else 'New'
	 end as customer_range,
age,
case when age<50 then 'Below age 50'
	 when age>=50 then '50 and Above'
	 end as age_group,

	 last_order,
	 datediff(month,last_order,getdate()) as recency,
	 total_orders,
total_products,
total_quantity,
total_sales,

	 lifespan,
	 --compute avg order--
	 case when lifespan=0 then 0
	 else total_sales/total_orders
	 end as avg_order_value,
	 --compute monthy spend--
	 case when lifespan=0 then total_sales
	 else total_sales/lifespan
	 end as monthly_spend
from customer_aggregation

;
