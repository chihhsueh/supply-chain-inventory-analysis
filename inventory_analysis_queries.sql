-- Q1 Which categories move the most vs least volume?
SELECT
    `Category Name` AS category,
    SUM(`Order Item Quantity`) AS total_units_sold,
    COUNT(DISTINCT `Order Id`) AS total_orders,
    ROUND(SUM(`Sales`), 2) AS total_revenue,
    ROUND(AVG(`Order Item Quantity`), 2) AS avg_units_per_order
FROM orders
WHERE `Order Status` IN ('COMPLETE', 'CLOSED')
GROUP BY `Category Name`
ORDER BY total_units_sold DESC;

-- Q2 What products have dropped in sales compared to their all time total? (Dead Stock)
SELECT
    `Product Name` AS product_name,
    `Category Name` AS category,
    SUM(`Order Item Quantity`) AS total_units_sold,
    COUNT(DISTINCT `Order Id`) AS total_orders
FROM orders
WHERE `Order Status` IN ('COMPLETE', 'CLOSED')
GROUP BY `Product Name`, `Category Name`
ORDER BY total_units_sold ASC
LIMIT 15;

-- Q3 Monthly units sold by category across all years
SELECT
    `Order Year` AS order_year,
    `Order Month` AS order_month,
    `Order Month Name` AS month_name,
    `Category Name` AS category,
    SUM(`Order Item Quantity`) AS total_units,
    ROUND(SUM(`Sales`), 2) AS total_revenue
FROM orders
WHERE `Order Status` IN ('COMPLETE', 'CLOSED')
GROUP BY `Order Year`, `Order Month`, `Order Month Name`, `Category Name`
ORDER BY `Order Year`, `Order Month`, `Category Name`;

-- Q4 Where are late deliveries concentrated
SELECT
    `Order Region` AS region,
    `Shipping Mode` AS shipping_mode,
    COUNT(*) AS total_orders,
    SUM(CASE WHEN `Late_delivery_risk` = 'Late Risk' THEN 1 ELSE 0 END) AS late_orders,
    ROUND(
        SUM(CASE WHEN `Late_delivery_risk` = 'Late Risk' THEN 1 ELSE 0 END)
        / COUNT(*) * 100, 1
    ) AS late_pct
FROM orders
GROUP BY `Order Region`, `Shipping Mode`
ORDER BY late_pct DESC;

-- Q5 Which categories generated the most profit and best margin
SELECT
    `Category Name` AS category,
    ROUND(SUM(`Order Profit Per Order`), 2) AS total_profit,
    ROUND(SUM(`Sales`), 2)  AS total_revenue,
    ROUND(
	SUM(`Order Profit Per Order`) / NULLIF(SUM(`Sales`), 0) * 100, 1) AS profit_margin_pct,
    COUNT(DISTINCT `Order Id`)  AS total_orders
FROM orders
WHERE `Order Status` IN ('COMPLETE', 'CLOSED')
GROUP BY `Category Name`
ORDER BY total_profit DESC;
 