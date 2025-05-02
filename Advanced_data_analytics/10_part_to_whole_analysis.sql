/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/

--	WHICH CATEGORIES CONTRIBUTE THE MOST TO OVERALL SAles--
with cat_range as (
select p.category as category,
sum(f.sales_amount) as total_sales
from gold.fact_sales f left join
gold.dim_products p on
f.product_key=p.product_key
group by p.category)
select category,
total_sales,
sum(total_sales)over() as sales,
concat(round(cast(total_sales as float)/sum(total_sales) over()*100,2),'%') as percentage_sales
from cat_range
order by total_sales desc;
