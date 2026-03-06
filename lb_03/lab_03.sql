-- 1 задание 
SELECT COUNT(DISTINCT product_type) as product_types_count
FROM products;
-- 2 задание
SELECT 
    product_type,
    MIN(base_msrp) as min_price
FROM products
GROUP BY product_type
ORDER BY min_price;

-- 3 задание
SELECT 
    d.city,
    AVG(s.sales_amount)::numeric(10,2) as avg_check
FROM dealerships d
JOIN sales s ON d.dealership_id = s.dealership_id
GROUP BY d.city
HAVING AVG(s.sales_amount) > 500
ORDER BY avg_check DESC;
