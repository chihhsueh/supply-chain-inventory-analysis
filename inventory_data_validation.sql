-- DATABASE SETUP
CREATE DATABASE sporting_goods_supply_chain_db;
USE sporting_goods_supply_chain_db;

-- Data inspection
SELECT * FROM orders LIMIT 3;
DESCRIBE orders;

-- Null check
SELECT
    SUM(CASE WHEN `Order Id` IS NULL THEN 1 ELSE 0 END) AS null_order_id,
    SUM(CASE WHEN `order date (DateOrders)` IS NULL THEN 1 ELSE 0 END) AS null_order_date,
    SUM(CASE WHEN `shipping date (DateOrders)` IS NULL THEN 1 ELSE 0 END) AS null_ship_date,
    SUM(CASE WHEN `Delivery Status` IS NULL THEN 1 ELSE 0 END) AS null_delivery_status,
    SUM(CASE WHEN `Late_delivery_risk` IS NULL THEN 1 ELSE 0 END) AS null_late_risk,
    SUM(CASE WHEN `Order Item Quantity` IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN `Order Profit Per Order` IS NULL THEN 1 ELSE 0 END) AS null_profit,
    SUM(CASE WHEN `Sales` IS NULL THEN 1 ELSE 0 END) AS null_sales,
    SUM(CASE WHEN `Order Status` IS NULL THEN 1 ELSE 0 END) AS null_order_status,
    SUM(CASE WHEN `Product Name` IS NULL THEN 1 ELSE 0 END) AS null_product_name
FROM orders;

-- Distinct categoricals
SELECT DISTINCT `Delivery Status` FROM orders;
SELECT DISTINCT `Late_delivery_risk` FROM orders;
SELECT DISTINCT `Order Status` FROM orders;
SELECT DISTINCT `Shipping Mode` FROM orders;


-- Duplicate Check
SELECT `Order Id`, COUNT(*) AS occurrences
FROM orders
GROUP BY `Order Id`
HAVING occurrences > 1
ORDER BY occurrences DESC;

-- Order ID Investigation
SELECT *
FROM orders
WHERE `Order Id` = 10964
ORDER BY `Order Id`;

SELECT `Order Id`, `Product Name`, `Order Item Quantity`, `Order Item Discount`, `Order Item Total`, `Order Profit Per Order`
FROM orders
WHERE `Order Id` = 10964
ORDER BY `Product Name`;