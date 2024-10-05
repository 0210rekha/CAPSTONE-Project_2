/* 1.Customer Analysis: */

/* 1.1 Demographic Distribution: */

SELECT 
  CustomerGender, 
  COUNT(*) AS total_customers, 
  CustomerCity, 
  CustomerState, 
  CustomerCountry, 
  continent,
  CASE 
    WHEN DATEDIFF(CURDATE(), CustomerBirthday)/365 < 30 THEN 'Under 30' 
    WHEN DATEDIFF(CURDATE(), CustomerBirthday)/365 BETWEEN 30 AND 50 THEN '30-50' 
    ELSE '50+' 
  END AS AgeGroup,
  FLOOR(DATEDIFF(CURDATE(), CustomerBirthday)/365) AS Age
FROM 
  MergedData 
GROUP BY 
  CustomerGender, 
  CustomerCity, 
  CustomerState, 
  CustomerCountry, 
  continent,
  AgeGroup,
  Age;


/* 1.2 Purchase Patterns (Average Purchase Value): */

WITH PurchasePatterns AS (
    SELECT 
        customerkey, 
        CustomerName, 
        COUNT(DISTINCT order_number) AS purchase_frequency,  -- Total number of distinct orders (Purchase Frequency)
        AVG(COALESCE(quantity, 0) * COALESCE(unit_price_usd, 0) * COALESCE(ExchangeRate, 1)) AS avg_order_value -- Average Order Value
    FROM 
        MergedData
    GROUP BY 
        customerkey, 
        CustomerName
), PreferredProduct AS (
    SELECT 
        customerkey, 
        CustomerName, 
        product_name,
        COUNT(product_name) AS product_order_count,  -- Count of how many times each product was ordered by the customer
        RANK() OVER (PARTITION BY customerkey ORDER BY COUNT(product_name) DESC) AS product_rank -- Rank to get the top preferred product for each customer
    FROM 
        MergedData
    GROUP BY 
        customerkey, 
        CustomerName, 
        product_name
)
SELECT 
    PP.customerkey, 
    PP.CustomerName, 
    PP.purchase_frequency,
    PP.avg_order_value,
    P.product_name AS top_preferred_product
FROM 
    PurchasePatterns PP
LEFT JOIN 
    PreferredProduct P 
    ON PP.customerkey = P.customerkey AND P.product_rank = 1 
ORDER BY 
    PP.customerkey;


/* Customer Segmentation (Based on Age and Spending): */

SELECT 
    CASE 
        WHEN DATEDIFF(CURDATE(), CustomerBirthday)/365 < 30 THEN 'Under 30' 
        WHEN DATEDIFF(CURDATE(), CustomerBirthday)/365 BETWEEN 30 AND 50 THEN '30-50' 
        ELSE '50+' 
    END AS AgeGroup, 
    SUM(COALESCE(quantity, 0) * COALESCE(unit_price_usd, 0) * COALESCE(ExchangeRate, 1)) AS total_spent
FROM MergedData
GROUP BY AgeGroup;


/* 2. Sales Analysis: */

/* 2.1 Overall Sales Performance (Trends Over Time): */

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month, 
    SUM(COALESCE(quantity, 0)) AS total_quantity, 
    SUM(COALESCE(unit_price_usd, 0)) AS total_price, 
    SUM(COALESCE(ExchangeRate, 1)) AS total_exchange_rate,
    SUM(COALESCE(quantity, 0) * COALESCE(unit_price_usd, 0) * COALESCE(ExchangeRate, 1)) AS total_sales
FROM MergedData
GROUP BY month
ORDER BY month;


/* 2.2 Sales by Product (Top Performers): */

SELECT 
    product_name, 
    ProductCategory, 
    SUM(COALESCE(quantity, 0)) AS total_quantity_sold
FROM MergedData
GROUP BY 
    product_name, 
    ProductCategory
ORDER BY total_quantity_sold DESC;


/* 2.3 Sales by Store:: */

SELECT 
    storekey, 
    StoreCountry, 
    StoreState, 
    SUM(COALESCE(quantity, 0) * COALESCE(unit_price_usd, 0) * COALESCE(ExchangeRate, 1)) AS total_sales
FROM MergedData
GROUP BY 
    storekey, 
    StoreCountry, 
    StoreState
ORDER BY total_sales DESC;


/* 2.4 Sales by Currency Impact: */

SELECT 
    currency, 
    SUM(COALESCE(quantity, 0) * COALESCE(unit_price_usd, 0) * COALESCE(ExchangeRate, 1)) AS total_sales_converted
FROM MergedData
GROUP BY currency
ORDER BY total_sales_converted DESC;


/* 3. Product Analysis */

/* 3.1 Product Popularity: */

SELECT 
    product_name, 
    ProductCategory, 
    SUM(COALESCE(quantity, 0)) AS total_quantity_sold
FROM MergedData
GROUP BY 
    product_name, 
    ProductCategory
ORDER BY total_quantity_sold DESC;



/* 3.2 Profitability Analysis: */

SELECT 
    product_name, 
    SUM(COALESCE(unit_price_usd, 0) - COALESCE(unit_cost_usd, 0)) AS profit_margin, 
    SUM(COALESCE(quantity, 0) * (COALESCE(unit_price_usd, 0) - COALESCE(unit_cost_usd, 0)) * COALESCE(ExchangeRate, 1)) AS total_profit
FROM MergedData
GROUP BY product_name
ORDER BY total_profit DESC;


/* 3.3 Category Analysis: */

SELECT 
    ProductCategory, 
    SUM(COALESCE(quantity, 0) * COALESCE(unit_price_usd, 0)) AS total_sales
FROM MergedData
GROUP BY ProductCategory
ORDER BY total_sales DESC;


/* 4. Store Analysis: */

/* 4.1 Store Performance: */

SELECT 
    storekey, 
    StoreCountry, 
    StoreState, 
    StoreArea, 
    StoreOpenDate,                 -- Added store open date
    DATEDIFF(CURDATE(), StoreOpenDate) / 365 AS years_in_operation,  -- Calculate years in operation
    SUM(COALESCE(quantity, 0) * COALESCE(unit_price_usd, 0) * COALESCE(ExchangeRate, 1)) AS total_sales
FROM 
    MergedData
GROUP BY 
    storekey, 
    StoreCountry, 
    StoreState, 
    StoreArea, 
    StoreOpenDate                -- Group by store open date for accurate year calculation
ORDER BY 
    StoreArea DESC,          -- Order by store area first
    total_sales DESC;        -- Then order by total sales



/* 4.2 Geographic Sales Analysis: */

SELECT 
    StoreCountry, 
    continent, 
    SUM(COALESCE(quantity, 0) * COALESCE(unit_price_usd, 0) * COALESCE(ExchangeRate, 1)) AS total_sales
FROM MergedData
GROUP BY 
    StoreCountry, 
    continent
ORDER BY total_sales DESC;








