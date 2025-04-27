/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/
/*Segment products into cost ranges and 
count how many products fall into each segment*/

select top 5 * from gold.dim_products;
select top 5 * from gold.fact_sales;


with cost_segment as(
select product_key,
product_name,
prd_cost,
case when prd_cost<=0 THEN 'Below 100'
	 when prd_cost BETWEEN 100 and 500 then 'Between 100-500'
	 when prd_cost between 500 and 1000 then 'Between 500-1000'
	 when prd_cost between 1000 and 1500 then 'Between 1000-1500'
	 else 'Above 1500'
	 end as cost_range
from gold.dim_products)
select
cost_range,
count(product_key) as total_products
from cost_segment
group by cost_range
order by total_products desc;

/*Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than €5,000.
	- Regular: Customers with at least 12 months of history but spending €5,000 or less.
	- New: Customers with a lifespan less than 12 months.
And find the total number of customers by each group
*/

select top 5 * from gold.dim_products;
select top 5 * from gold.fact_sales;
select top 5 * from gold.dim_customers;

with customer_segment As(
select f.customer_key as customer_key,
concat(c.first_name,' ',c.last_name) as Customer_name,
sum(f.sales_amount) as total_sales,
min(f.order_date) as first_order,
max(f.order_date) as last_order,
datediff(month,min(f.order_date),max(f.order_date)) as life_span
from
gold.fact_sales f left join 
gold.dim_customers c ON
f.customer_key=c.customer_key
where f.order_date is not null
group by f.customer_key,concat(c.first_name,' ',c.last_name)
)
select customer_range,
count(customer_key) as total_customers
from
(
select customer_key,
Customer_name,
case when life_span<=12 and total_sales<5000 then 'VIP'
	 when life_span<=12 and total_sales>=5000 then 'Regular'
	 else 'New'
	 end as customer_range
from customer_segment)
as sg
group by customer_range;