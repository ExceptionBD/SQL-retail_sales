create database Aspiring
use Aspiring
select * from retail_sales
select count(*) from retail_sales
ALTER TABLE retail_sales
RENAME COLUMN quantiy TO quantity;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR 
    sale_time IS NULL OR 
    customer_id IS NULL OR 
    gender IS NULL OR 
    age IS NULL OR 
    category IS NULL OR 
    quantity IS NULL OR 
    price_per_unit IS NULL OR 
    cogs IS NULL;
    
    -- q-1Write a SQL query to retrieve all columns for sales made on '2022-11-05:
    SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
    
    select * from retail_sales
    where sale_date='2022-11-05'
    
   --  2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
  -- 3  Write a SQL query to calculate the total sales (total_sale) for each category.:

  select category,Sum(total_sale),
  count(*) as total_count
  from retail_sales
  group by category
  
  -- 4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

  select Round(avg(age),2) as a_age 
  from retail_sales
  where category='Beauty'
  
  -- 5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail_sales
WHERE total_sale > 1000
-- 6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1

-- 7  Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

select *
from(
select year(sale_date) as Year,
month(sale_date) as Month,
avg(total_sale) as Total_sale,
Rank() over(partition by year(sale_date) order by avg(total_sale) desc) as Ran
from retail_sales
group by 1,2) as t1
-- order by 1,2 
where Ran=1

-- 8 **Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id, sum(total_sale)
from retail_sales
group by 1
order by 2 desc limit 5

-- 9 Write a SQL query to find the number of unique customers who purchased items from each category.:

select count(distinct customer_id) customer_amount,
category
from retail_sales
group by 2

-- 10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

with cte_table
as(
select *,
case
when hour(sale_time)<12 then 'Morning'
when hour(sale_time) between 12 and 17 then 'Afternoon'
else
'Evening'
End as shift
from retail_sales
)

select shift,
count(*) orders
from cte_table
group by 1



  