use projects;
# Data overview 
select *
from currencies_data;

# Unique coins
select distinct name,symbol
from currencies_data;

# How many unique records are present
select distinct count(*)
from currencies_data;

# Show the top 10 cryptocurrencies
select distinct name, cmcRank
from currencies_data
order by cmcRank asc
limit 10;

# Find out the first and last recorded date of bitcoin prices
select min(dateAdded) first_date, max(dateAdded) last_date
from currencies_data;

# Show the percentage change of price in 90 days.
Select name,price as cuurentprice, percentChange1h  ,percentChange24h,percentChange7d,
 percentChange30d,percentChange60d, percentChange90d
from currencies_data;

# Most traded coins
select distinct name,symbol,volume24h, totalsupply
from currencies_data
order by volume24h desc, totalsupply desc;

# Which date had the most volume traded and what was the close_price for that day?
select dateAdded, price
from currencies_data
where volume24h = (select max(volume24h) from currencies_data)
limit 1;


# If you invested 10,000 on the 1st January 2016 — how much is your investment worth in 1st of February 2021? 
WITH initial AS (
SELECT price
FROM currencies_data
WHERE dateAdded = '2016-01-01'), 
latest AS (
SELECT price
FROM currencies_data
WHERE dateAdded = '2021-01-01')

SELECT ROUND(latest.price/initial.price * 10000,2) as investment
FROM initial cross join latest;

# What is the average daily volume for the last 7 days?
SELECT 
    dateAdded,
    (SELECT AVG(volume24h) 
     FROM currencies_data AS c2 
     WHERE c2.dateAdded BETWEEN DATE_SUB(c1.dateAdded, INTERVAL 7 DAY) AND DATE_SUB(c1.dateAdded, INTERVAL 1 DAY)
    ) AS daily_avg
FROM 
    currencies_data AS c1;



