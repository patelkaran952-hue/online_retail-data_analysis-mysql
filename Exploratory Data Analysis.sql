-- Exploratory Data Analysis

-- Total Revenue
SELECT SUM(TotalPrice) FROM online_retail3;  -- '10645096.63'

-- Total Revenue lost due to return items 
SELECT SUM(TotalPriceReturn) FROM online_retail3;  -- '-893979.73'


-- Country Analysis
update online_retail3
set country = trim(country);

UPDATE online_retail3
SET country = TRIM(UPPER(country));


-- Revenue of each country
SELECT Country, SUM(TotalPrice) AS revenue
FROM online_retail3
GROUP BY Country
ORDER BY revenue DESC;

-- Revenue lost by each country
SELECT Country, SUM(TotalPriceReturn) AS revenue
FROM online_retail3
GROUP BY Country
ORDER BY revenue DESC;


-- Top Products
SELECT Description, SUM(Quantity) AS total_sold
FROM online_retail3
GROUP BY Description
ORDER BY total_sold DESC
LIMIT 10;


-- Top Products in each country
SELECT *
FROM (
    SELECT 
        Country,
        Description,
        SUM(Quantity) AS total_sold,
        ROW_NUMBER() OVER (
            PARTITION BY Country
            ORDER BY SUM(Quantity) DESC
        ) AS rank_in_country
    FROM online_retail3
    WHERE Quantity > 0
      AND StockCode NOT IN ('POST', 'DOT', 'M')
    GROUP BY Country, Description
) t
WHERE rank_in_country <= 10;


-- Top Returned Products
SELECT Description, SUM(Quantity) AS total_sold
FROM online_retail3
WHERE Quantity < 0
GROUP BY Description
ORDER BY total_sold ASC
LIMIT 10;


-- Top Returned Products in each country
SELECT *
FROM (
    SELECT 
        Country,
        Description,
        SUM(Quantity) AS total_sold,
        ROW_NUMBER() OVER (
            PARTITION BY Country
            ORDER BY SUM(Quantity) ASC
        ) AS rank_in_country
    FROM online_retail3
    WHERE Quantity < 0
      AND StockCode NOT IN ('POST', 'DOT', 'M')
    GROUP BY Country, Description
) t
WHERE rank_in_country <= 10;


-- Customer Analysis

-- Top Customers
SELECT CustomerID, SUM(TotalPrice) AS spending
FROM online_retail3
WHERE CustomerID != 0
GROUP BY CustomerID
ORDER BY spending DESC
LIMIT 10;


-- Revenue per month
SELECT Year, Month, SUM(TotalPrice) AS revenue
FROM online_retail3
GROUP BY Year, Month
ORDER BY Year, Month;

-- Revenue lost per month
SELECT Year, Month, SUM(TotalPriceReturn) AS revenue
FROM online_retail3
GROUP BY Year, Month
ORDER BY Year, Month;


SELECT Year, Month, SUM(TotalPrice) AS revenue, SUM(TotalPriceReturn) as revenue_lost
FROM online_retail3
GROUP BY Year, Month
ORDER BY Year, Month;

SELECT Year, SUM(TotalPrice) AS revenue, SUM(TotalPriceReturn) as revenue_lost
FROM online_retail3
GROUP BY Year
ORDER BY Year;










