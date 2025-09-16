SELECT * FROM salesdatawalmart.sales;

Create database if not exists salesDataWalmart;
    
   create table if not exists sales(
     Invoice_id varchar(30) not Null primary key ,
     Branch varchar(5) Not null,
     City varchar(30) not null,
     Customer_type varchar(30) not null,
     Gender varchar(10) not null,
     Product_line varchar(100) not null,
     Unit_price decimal(10 , 2) not null,
     Quantity int not null,
     Tax float(8,4) not null,
     Total decimal(12,5) not null,
     Date Datetime not null,
     Time time not null,
     Payment varchar(15) not null,
     cogs decimal(10,2) not null,
     gross_margin_percentage float(10,9) not null,
     gross_income decimal(12,4) not null,
     Rating float(2,1) 
     );
     
     
SELECT * FROM salesdatawalmart.sales;

-- -------------------------------- Feature Engineering ----------------------------------------------
-- ---------------------------------------------------------------------------------------------------

SELECT
	Time,
	(CASE
		WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `Time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END) AS time_of_day
FROM sales;


-- Add new column name as time_of_day ---
 
Alter table sales add column time_of_day varchar(25);

update sales
set time_of_day = (CASE
		WHEN `Time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `Time` BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
    END);


-- add new column name as day_name --
select Date,
dayname(Date)
from sales;

Alter table sales add column day_name varchar(25);

update sales
set day_name= dayname(Date);

-- Add new column name as month_name --
 alter table sales add column month_name varchar(10);
 
 update sales
      set month_name = monthname(Date);


-- --------------------------------------------------------------------
-- ---------------------------- Generic ------------------------------
-- --------------------------------------------------------------------

-- 1. How many unique cities does the data have?      

select distinct City
from sales;

-- 2. In which city is each branch?

select 
     distinct City,
     Branch
from sales;


-- --------------------------------------------------------------------
-- ---------------------------- Product -------------------------------
-- --------------------------------------------------------------------

-- 1. How many unique product lines does the data have?

 select 
       distinct Product_line
from sales;

-- 2. What is the most common payment method?

select Payment, 
       count(*) as count
from sales
group by Payment
order by count desc
limit 1 ;
     
-- 3. What is the most selling product line?
select 
     sum(Quantity) as quantity,
     Product_line
from sales
group by Product_line
order by quantity Desc;

-- 4. What is the total revenue by month?

select 
      month_name,
      sum(Total) as total_revenue
from sales
group by month_name
order by total_revenue;


-- 5. What month had the largest COGS?
 select 
       month_name,
       sum(cogs) as cogs
from sales
group by month_name
order by cogs desc;

-- 6. What product line had the largest revenue?

select 
      Product_line,
      sum(Total) as revenue
from sales
group by Product_line
order by revenue Desc
limit 1;

-- 7.  What is the city with the largest revenue?


select City,
	Branch,
    sum(Total) as city_revenue
from sales
group by City, Branch
order by city_revenue;

-- 8.  What product line had the largest VAT?
select 
     Product_line,
     sum(tax) as tax
from sales
group by Product_line
order by tax Desc;

-- 9.Fetch each product line and add a column to those product 
-- line showing "Good", "Bad". Good if its greater than average sales.

select 
avg(Quantity)
from sales;

select 
      Product_line,
      case
          when avg(Quantity)> 6 then "GOOD"
          Else "BAD"
	  end as Remark
from sales
group by Product_line;

-- 10. Which branch sold more products than average product sold?

select 
      Branch,City,
      sum(Quantity) as qnty
from sales
group by Branch,City
having sum(Quantity) >(
select avg(Quantity) 
from 
    sales);
    
-- 11.  What is the most common product line by gender?
select 
      Gender,
      Product_line,
      count(Gender) as total_count
from sales
group by Gender, Product_line
order by total_count Desc;
    
-- 12.  What is the average rating of each product line?

SELECT 
      ROUND(avg(Rating),2) as avg_rating,
      Product_line
from
    sales
group by Product_line
order by avg_rating desc;

-- --------------------------------------------------------------------
-- --------------------------------------------------------------------

-- --------------------------------------------------------------------
-- ---------------------------- Sales ---------------------------------
-- --------------------------------------------------------------------

-- 1. Number of sales made in each time of the day per weekday 

select 
     time_of_day,
     count(*) as total_sales
from sales
where day_name ='Sunday'
group by time_of_day
order by total_sales DESC ;

-- 2. Which of the customer types brings the most revenue?

select 
      Customer_type,
      sum(Total) as total_revenue
from sales
group by Customer_type
order by total_revenue desc 
limit 1 ;

-- 3. Which city has the largest tax/VAT percent?

select 
      City,
      avg(Tax) as avg_tax
from sales
group by City
Order by avg_tax Desc;

-- 4. Which customer type pays the most in VAT?
SELECT * FROM salesdatawalmart.sales;

select 
     Customer_type,
     avg(Tax)  as  total_tax
from sales
group by Customer_type
order by total_tax desc
limit 1;

-- -----------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------

-- ----------------------------- Customers -------------------------------------------------

-- 1. How many unique customer types does the data have?
 select 
       distinct Customer_type
from sales;

-- 2. -- How many unique payment methods does the data have?
SELECT
	DISTINCT Payment
FROM sales;

-- 3. What is the most common customer type?
SELECT
	Customer_type,
	count(*) as count
FROM sales
GROUP BY Customer_type
ORDER BY count DESC;

-- 4. -- What is the gender distribution per branch?

select
      Gender,
      count(*) as gender_count
from sales
where Branch= "C"
group by Gender
order by gender_count desc;


     