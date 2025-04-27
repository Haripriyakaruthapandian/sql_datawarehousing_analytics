/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue


	   select top 5 * from gold.dim_products;
select top 5 * from gold.fact_sales;
select top 5 * from gold.dim_customers;
===============================================================================
*/


create view products_report as
with base_query as(
select p.product_key as product_key,
p.product_name as product_name,
p.category as category,
p.sub_category as subcategory,
p.prd_cost as cost,
f.sales_amount as sales_amount,
f.order_number as order_number,
f.quantity as quantity,
f.customer_key as customer_key,
f.order_date as order_date
from gold.fact_sales f
left join gold.dim_products p
on f.product_key=p.product_key
where f.order_date is not null
),
product_aggregations as(
select 
product_key,
product_name,
category,
subcategory,
cost,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity,
count(distinct order_number) as total_orders,
DATEDIFF(month,min(order_date),max(order_date))as lifespan,
max(order_date) as last_order,
round(avg(cast(sales_amount as float)/nullif(quantity,0)),1) as average_order_revenue
from base_query
group by product_key,
product_name,
category,
subcategory,
cost


)
select 
product_key,
product_name,
category,
subcategory,
cost,
case when total_sales>50000 then 'High Performer'
	 when total_sales>=10000 then 'Mid-Range'
	 else 'Low_performer'
	 end as product_segment,
total_sales,
total_orders,
total_quantity,
total_customers,
last_order,

lifespan,


datediff(month,last_order,GETDATE()) as recency,
average_order_revenue,

case when lifespan=0 then 0
	 else total_sales/lifespan
	 end as avg_monthly_revenue

from product_aggregations;
