CREATE TABLE MergedData AS
SELECT 
  sd.order_number,
  sd.line_item,
  sd.order_date,
  sd.delivery_date,
  sd.quantity,
  sd.currency_code,
  sd.customerkey,
  c.name AS CustomerName, -- From Customers table
  c.gender AS CustomerGender, -- From Customers table
  c.city AS CustomerCity, -- From Customers table
  c.state AS CustomerState, -- From Customers table
  c.country AS CustomerCountry, -- From Customers table
  c.birthday AS CustomerBirthday, -- From Customers table
  c.state_code,
  c.zip_code,
  c.continent,
  p.product_name, -- From Products table
  p.brand AS ProductBrand, -- From Products table
  p.color AS ProductColor, -- From Products table
  p.unit_cost_usd, -- From Products table
  p.unit_price_usd, -- From Products table
  p.category AS ProductCategory, -- From Products table
  p.subcategorykey,
  p.subcategory,
  st.storekey, -- From Stores table
  st.country AS StoreCountry, -- From Stores table
  st.state AS StoreState, -- From Stores table
  st.square_meters AS StoreArea, -- From Stores table
  st.open_date AS StoreOpenDate, -- From Stores table
  er.exchange AS ExchangeRate, -- From ExchangeRates table
  er.currency,
  er.DATE
FROM 
  Sales sd
JOIN 
  Customers c ON sd.customerkey = c.customerkey -- Join on CustomerKey
JOIN 
  Products p ON sd.productkey = p.productkey -- Join on ProductKey
JOIN 
  Stores st ON sd.storekey = st.storekey -- Join on StoreKey
JOIN 
  ExchangeRates er ON sd.order_date = er.date AND sd.currency_code = er.currency -- Join on Date and CurrencyCode for exchange rates;