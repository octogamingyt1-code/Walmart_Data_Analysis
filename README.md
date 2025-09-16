
<img width="500" height="281" alt="Walmart-Logo" src="https://github.com/user-attachments/assets/92776a1c-f6c4-4fb8-ab50-b95f965fe89e" />

# Walmart Sales Data Analysis


## About

This project aims to explore the Walmart Sales data to understand top performing branches and products, sales trend of of different products, customer behaviour. The aims is to study how sales strategies can be improved and optimized. The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting).

"In this recruiting competition, job-seekers are provided with historical sales data for 45 Walmart stores located in different regions. Each store contains many departments, and participants must project the sales for each department in each store. To add to the challenge, selected holiday markdown events are included in the dataset. These markdowns are known to affect sales, but it is challenging to predict which departments are affected and the extent of the impact." [source](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting)

## Purposes Of The Project

The major aim of thie project is to gain insight into the sales data of Walmart to understand the different factors that affect sales of the different branches.

## About Data

The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/c/walmart-recruiting-store-sales-forecasting). This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows:

| Column                  | Description                             | Data Type      |
| :---------------------- | :-------------------------------------- | :------------- |
| Invoice_id              | Invoice of the sales made               | VARCHAR(30)    |
| Branch                  | Branch at which sales were made         | VARCHAR(5)     |
| City                    | The location of the branch              | VARCHAR(30)    |
| Customer_type           | The type of the customer                | VARCHAR(30)    |
| Gender                  | Gender of the customer making purchase  | VARCHAR(10)    |
| Product_line            | Product line of the product solf        | VARCHAR(100)   |
| Unit_price              | The price of each product               | DECIMAL(10, 2) |
| Quantity                | The amount of the product sold          | INT            |
| Tax                     | The amount of tax on the purchase       | FLOAT(8, 4)    |
| Total                   | The total cost of the purchase          | DECIMAL(12, 5) |
| Date                    | The date on which the purchase was made | DATE           |
| Time                    | The time at which the purchase was made | TIMESTAMP      |
| Payment                 | The total amount paid                   | DECIMAL(10, 2) |
| cogs                    | Cost Of Goods sold                      | DECIMAL(10, 2) |
| gross_margin_percentage | Gross margin percentage                 | FLOAT(11, 9)   |
| gross_income            | Gross Income                            | DECIMAL(12, 4) |
| Rating                  | Rating                                  | FLOAT(2, 1)    |

### Analysis List

1. Product Analysis

> Conduct analysis on the data to understand the different product lines, the products lines performing best and the product lines that need to be improved.

2. Sales Analysis

> This analysis aims to answer the question of the sales trends of product. The result of this can help use measure the effectiveness of each sales strategy the business applies and what modificatoins are needed to gain more sales.

3. Customer Analysis

> This analysis aims to uncover the different customers segments, purchase trends and the profitability of each customer segment.

## Approach Used

1. **Data Wrangling:** This is the first step where inspection of data is done to make sure **NULL** values and missing values are detected and data replacement methods are used to replace, missing or **NULL** values.

> 1. Build a database
> 2. Create table and insert the data.
> 3. Select columns with null values in them. There are no null values in our database as in creating the tables, we set **NOT NULL** for each field, hence null values are filtered out.

2. **Feature Engineering:** This will help use generate some new columns from existing ones.

> 1. Add a new column named `time_of_day` to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.

> 2. Add a new column named `day_name` that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.

> 3. Add a new column named `month_name` that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.

2. **Exploratory Data Analysis (EDA):** Exploratory data analysis is done to answer the listed questions and aims of this project.

3. **Conclusion:**

## Business Questions To Answer

### Generic Question

1. How many unique cities does the data have?
2. In which city is each branch?

### Product

1. How many unique product lines does the data have?
2. What is the most common payment method?
3. What is the most selling product line?
4. What is the total revenue by month?
5. What month had the largest COGS?
6. What product line had the largest revenue?
5. What is the city with the largest revenue?
6. What product line had the largest VAT?
7. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
8. Which branch sold more products than average product sold?
9. What is the most common product line by gender?
12. What is the average rating of each product line?

### Sales

1. Number of sales made in each time of the day per weekday
2. Which of the customer types brings the most revenue?
3. Which city has the largest tax percent/ VAT (**Value Added Tax**)?
4. Which customer type pays the most in VAT?

### Customer

1. How many unique customer types does the data have?
2. How many unique payment methods does the data have?
3. What is the most common customer type?
4. Which customer type buys the most?
5. What is the gender of most of the customers?
6. What is the gender distribution per branch?
7. Which time of the day do customers give most ratings?
8. Which time of the day do customers give most ratings per branch?
9. Which day fo the week has the best avg ratings?
10. Which day of the week has the best average ratings per branch?


## Revenue And Profit Calculations

$ COGS = unitsPrice * quantity $

$ VAT = 5\% * COGS $

$VAT$ is added to the $COGS$ and this is what is billed to the customer.

$ total(gross_sales) = VAT + COGS $

$ grossProfit(grossIncome) = total(gross_sales) - COGS $

**Gross Margin** is gross profit expressed in percentage of the total(gross profit/revenue)

$ \text{Gross Margin} = \frac{\text{gross income}}{\text{total revenue}} $

<u>**Example with the first row in our DB:**</u>

**Data given:**

- $ \text{Unite Price} = 45.79 $
- $ \text{Quantity} = 7 $

$ COGS = 45.79 * 7 = 320.53 $

$ \text{VAT} = 5\% * COGS\\= 5\%  320.53 = 16.0265 $

$ total = VAT + COGS\\= 16.0265 + 320.53 = $336.5565$

$ \text{Gross Margin Percentage} = \frac{\text{gross income}}{\text{total revenue}}\\=\frac{16.0265}{336.5565} = 0.047619\\\approx 4.7619\% $

## Code



```sql
-- Create database
CREATE DATABASE IF NOT EXISTS walmartSales;

-- Create table
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

