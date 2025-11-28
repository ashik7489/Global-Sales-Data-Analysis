use employee;
select * from storedata;
select count(*) from sales_data;

-- A. Basic Selection (10 Questions)

-- Write a query to display all columns from the sales table.
select * from sales_data;
-- Retrieve all sales records from India.
select * from sales_data where country='India';
-- Retrieve all sales where the Item = 'Microwave'.
select * from sales_data where item='microwave';
-- Get all records where Discount % > 0.20.
select * from sales_data where 'Discount %' >= '0.20';
-- Show all sales done in the year 2018.
select * from sales_data where year(date_clean_new) = 2018;


SELECT *
FROM sales_data;

alter table sales_data add column date_clean_new date;

update sales_data set date_clean_new=str_to_date(date_clean, '%d-%m-%Y');
set sql_safe_updates=0;
alter table sales_data drop column date_clean;
alter table sales_data change column date_clean_new d_date date;
-- Display Store, Country, Item, and Actual Price.
select * from sales_data;
select store,country, item, 'Actual Price' from sales_data;
alter table sales_data change column `Actual price`  `Actual_price` int;
alter table sales_data change column `list price` `list_price` int;
-- Retrieve rows where Actual Price = List Price (no discount).
select * from sales_data where Actual_price=list_price;
-- Retrieve all sales from the region LATAM.
select * from sales_data where region='latam';
-- Retrieve all transactions done by Salesperson = ‘Gary Reynolds’.
select * from sales_data where salesperson='gary reynolds';
-- Find all products sold in Canada.
select * from sales_data where country='canada';
-- 📌 B. Filtering & Sorting (10 Questions)

-- Retrieve the top 10 highest-priced items (Actual Price).
select item, sum(Actual_price) as highest_priced from sales_data
group by item
order by highest_priced desc 
limit 10;
select item, salesperson, sum(actual_price) as ac from sales_data
group by item,salesperson
having item='microwave'
order by ac desc
limit 1 ;

-- Show all transactions sorted by Date_Clean (latest first).
select* from sales_data
order by d_date desc;
show columns from sales_data;
-- Display the lowest 5 Actual Price sales.
select * from sales_data 
order by actual_price 
limit 5;
-- Retrieve all sales where Discount % is between 0.10 and 0.30.
select * from sales_data where `discount %` between 0.10 and 0.30;
-- Get all stores that sold an item priced below 40.
select store , list_price from sales_data 
where list_price<40;
-- Retrieve all sales for Toaster in APAC region.
select store,item,region from sales_data
where item='toaster' and region='apac';
-- Show all Refrigerator sales with discount more than 0.25.
select * from sales_data where item='refrigerator'
and `discount %` >0.25;
-- Find the total number of unique cities (Store column).
select count(distinct store) from sales_data;
-- Show all Iron sales in descending order of Actual Price.
select item, actual_price from sales_data
order by actual_price desc;
-- Show all Microwave sales where List Price > 70.
select * from sales_data where item='microwave' and list_price >70;
-- 📌 C. Aggregation (10 Questions)

-- Find the total revenue (sum of Actual Price).
select sum(actual_price) from sales_data;
-- Find the average discount percentage.
select avg(`discount %`) from sales_data;
-- Count how many transactions happened in each region.
select region, count(*) from sales_data
group by region;
-- Calculate total revenue per country.
select country, sum(actual_price) from sales_data
group by country;
-- Find total number of items sold per Item category.
select item,count(*) from sales_data 
group by item;
-- Find maximum Actual Price for each Item.
select item,max(actual_price) from sales_data
group by item;
-- Find minimum Discount % for each Region.
select region,min(`discount %`) from sales_data
group by region;

-- Compute total orders per salesperson.
select salesperson, count(*) from sales_data 
group by salesperson 
order by count(*) desc;
-- Calculate revenue difference (List - Actual) per Item.
select item, sum(list_price- actual_price)from sales_data
group by item;
-- Find the country with the highest total revenue.
select country, sum(actual_price) from sales_data
 group by country;
-- 📌 D. Joins (Based on assumptions of related tables) (5 Questions)

-- (If you have a separate Country or Region table — optional)
-- 31. Join Sales with Region table to get Region Name.
select * from sales_data as a
join region as b
on a.id=b.id;
CREATE TABLE region (
    Region_Code VARCHAR(10),
    Region_Name VARCHAR(50)
);
INSERT INTO region (Region_Code, Region_Name) VALUES
('APAC', 'Asia Pacific'),
('EMEA', 'Europe, Middle East & Africa'),
('NA', 'North America'),
('LATAM', 'Latin America');


-- 32. Join Sales and Country to get Continent name.
select * from sales_data as a
 left join region as b
on a.`je code`=b.region_code;

-- 33. Show total revenue by joining Sales + Product table.
select sum(actual_price) from sales_data as a
join region as b
on a.`je code`=b.region_code;
-- 34. Show salesperson details by joining Sales + Employee table.
select * from sales_data as a
join employeess as b
on a.`je code`=b.imp_id;
-- 35. Find region-wise total discount by joining two tables.
select region,
sum(list_price- actual_price)
from sales_data as a
join region as b
on a.`je code`= b.region_code
group by region;
-- 📌 E. Window Functions (10 Questions)

-- Add a ROW_NUMBER to display row order by revenue.
select 
row_number() over (order by actual_price desc) as row_num,
store,
country,
item ,
actual_price as revenue 
from sales_data;
-- Rank countries by total revenue (highest first).
select 
country,
sum(actual_price) as total_revenue,
rank() over (order by sum(actual_price) desc) as revenue_renk
from sales_data
group by country;

-- Calculate cumulative revenue (running total) by Date_Clean.
select d_date,
actual_price as revenue,
sum(actual_price) over (order by d_date) as cumulative_revenue
from sales_data
order by d_date;

-- Show highest selling item per region using RANK().
select 
item,
region,
sum(actual_price) as total_revenue,
rank() over (partition by region order by sum(actual_price) desc) as revenue_rank
from sales_data
group by region,item;
select*from(select item,actual_price as revenue,
row_number() over
(partition by item
order by actual_price desc) as rn
from sales_data ) t
where rn<=3
order by item,rn;

-- Calculate average Actual Price per Region using window function.
select 
region,
actual_price,
avg(actual_price)  over(partition by region )as avg_actual_price
from sales_data;
-- Use LAG() to show previous sale's Actual Price for each country.
select 
country,
d_date,
actual_price,
lag(actual_price,1) over(partition by country order by d_date)as previes_price
from sales_data
order by country,d_date;
-- Use LEAD() to see next transaction for each store.
select 
country,
d_date,
actual_price,
lead(actual_price,1) over(partition by country order by d_date) as next_price
from sales_data
order by country,d_date;
-- Show month-over-month revenue change using window function.
SELECT
    YEAR(d_date) AS yr,
    MONTH(d_date) AS mn,
    SUM(actual_price) AS monthly_revenue,
    LAG(SUM(actual_price), 1) OVER (
        ORDER BY YEAR(d_date), MONTH(d_date)
    ) AS prev_month_revenue,
    SUM(actual_price) -
    LAG(SUM(actual_price), 1) OVER (
        ORDER BY YEAR(d_date), MONTH(d_date)
    ) AS mom_change
FROM sales_data
GROUP BY YEAR(d_date), MONTH(d_date)
ORDER BY yr, mn;

-- Find salesperson with maximum discount % per region.
select * from(
select 
region,
salesperson,
`discount %`,
rank()over(partition by region
order by `discount %` desc)rnk
from sales_data) t
where rnk=1;

-- 📌 F. Advanced SQL (5 Questions)

-- Write a CTE to calculate total revenue per region.
with region_revenue as(
select 
region, 
sum(actual_price) as total_revenue
from sales_data
group by region
)
select region,total_revenue from region_revenue
order by total_revenue desc;
use employee;
-- Write a query to find stores where more than 5 different items were sold.
select 
store,
count(distinct item) as total_items_sold
from sales_data
group by store
having count(distinct item)>5;
-- Identify countries where average discount is more than 0.20.
select 
country,
avg(`discount %`) as avg_discount
from sales_data
group by  country
having avg(`discount %`) >0.10;

-- Find salespersons who sold multiple different item categories.
select 
salesperson,
count(distinct item) as total_categories_sold
from sales_data
group by salesperson
having count(distinct item)>1;
-- Pivot the data to show Item Categories as columns and regions as rows with total 
SELECT 
    Region,
    ISNULL(`Microwave`, 0) AS Microwave,
    ISNULL(`Refrigerator`, 0) AS Refrigerator,
    ISNULL(`TV`, 0) AS TV,
    ISNULL(`Oven`, 0) AS Oven
FROM
(
    SELECT 
        Region,
        Item,
        Actual_Price
    FROM sales_data
) AS src
PIVOT (
    SUM(Actual_Price)
    FOR Item IN (`Microwave`, `Refrigerator`, `TV`, `Oven`)
) AS p;
SELECT 
    Region,
    ISNULL([Microwave], 0) AS Microwave,
    ISNULL([Refrigerator], 0) AS Refrigerator,
    ISNULL([TV], 0) AS TV,
    ISNULL([Oven], 0) AS Oven
FROM
(
    SELECT 
        Region,
        Item,
        Actual_Price
    FROM sales_data
) AS src
PIVOT (
    SUM(Actual_Price)
    FOR Item IN ([Microwave], [Refrigerator], [TV], [Oven])
) AS p;

-- revenue.


-- 1️⃣ Total Revenue per Region using CTE


-- 2️⃣ Total Discount Amount per Country
select 
country,
sum(list_price-actual_price) as total_discount
from sales_data
group by country;
order by total_discount desc;

with discount_cte as (
select 
country,
(list_price-actual_price) as discount_amount
from sales_data
)
select 
country,
sum(discount_amount) as total_discount_amount
from discount_cte
group by country
order by total_discount_amount desc;
