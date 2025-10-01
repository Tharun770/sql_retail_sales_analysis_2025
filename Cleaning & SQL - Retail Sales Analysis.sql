CREATE DATABASE sql_project_p2;

DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transaction_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantity	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );

select * from retail_sales
Limit 10

select * from retail_sales;


select * from retail_sales
where 
      transaction_id is Null
	  or
	  sale_date is null
	  or 
	  sale_time is null
	  or
	  customer_id is null
	  or
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantity is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or 
	  total_sale is null;

---deleting the null values

delete from retail_sales
where 
      transaction_id is Null
	  or
	  sale_date is null
	  or 
	  sale_time is null
	  or
	  customer_id is null
	  or
	  gender is null
	  or
	  age is null
	  or
	  category is null
	  or
	  quantity is null
	  or
	  price_per_unit is null
	  or
	  cogs is null
	  or 
	  total_sale is null;

-- How many sales we have?
select count(*) as total_sale from retail_sales;

-- How many uniuque customers we have ?
select count(distinct customer_id) as uni_cust from retail_sales;

SELECT  distinct category FROM retail_sales


 -- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
 select * from retail_sales
 where sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold is more than 4 in the month of Nov-2022....????

select * from retail_sales
where 
      category = 'Clothing'
	  and
	  TO_CHAR(sale_date,'yyyy-mm')='2022-11'
	  and
	  quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT 
       CATEGORY,
	   SUM(total_sale) as Net_sale,
	   count(*) as total_orders
From retail_sales
Group by 1;

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.----

 select round(avg(age)) from retail_sales
 where Category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
select * from retail_sales
where total_sale >= 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select
       category,
	   gender,
	   count(*) as total_trans
	   
From retail_sales
group by
         category,
		 gender
Order by 1
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select 
        year,
		month,
		avg_sale
from(
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    round(AVG(total_sale)) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
where rank = 3


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
       Customer_id,
	   sum(total_sale) as high_ts    
FROM RETAIL_SALES
Group by 1
order by 2 desc
Limit 5


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
       Category,
	   count(distinct customer_id) as uniq_cust
From retail_sales
Group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

With t1
AS
(
select *,
       CASE
	   WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
	   WHEN EXTRACT(HOUR FROM sale_time) < 12 & 17 THEN 'AfterNoon'
	 ELSE 'Evening'
  END as shift 
From retail_sales
)
select 
       shift,
	   count(*) as total_orders
From t1
Group by 1

	   
        











