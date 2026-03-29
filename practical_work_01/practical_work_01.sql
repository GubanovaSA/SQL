CREATE EXTENSION IF NOT EXISTS cube;
CREATE EXTENSION IF NOT EXISTS earthdistance;

-- 1 задание

SELECT 
    TO_CHAR(sales_transaction_date, 'Day') AS day_name,
    COUNT(*) AS total_sales
FROM sales
GROUP BY day_name
ORDER BY total_sales DESC;


-- 2 задание

SELECT 
    c.customer_id,
    d.dealership_id,
    MIN(point(c.longitude, c.latitude) <@> point(d.longitude, d.latitude)) AS min_distance
FROM customers c
JOIN dealerships d ON TRUE
WHERE c.city = 'New York City'
GROUP BY c.customer_id, d.dealership_id
ORDER BY c.customer_id, min_distance;


-- 3 
SELECT *
FROM customer_survey
WHERE 
    to_tsvector('english', feedback) @@ 
    to_tsquery('english', 'bad:* | fail:* | poor:*');

SELECT * FROM customer_survey LIMIT 10;

INSERT INTO customer_survey (rating, feedback) VALUES
-- Негатив (с нужными словами)
(1, 'This is a bad product'),
(2, 'Very bad quality, not recommended'),
(1, 'The system failed after two days'),
(2, 'It keeps failing and crashing'),
(1, 'Poor build quality'),
(2, 'This is a poorly designed item'),

-- Негатив (другие формулировки)
(1, 'Terrible experience, very disappointed'),
(2, 'I had an issue with the service'),
(1, 'No help from support, very frustrating'),
(3, 'I will be returning this product soon'),
(2, 'The service was awful and slow'),

-- Позитив
(9, 'Amazing product, I love it'),
(10, 'Excellent quality and great service'),
(8, 'Very satisfied with my purchase'),
(9, 'Fast delivery and good support'),

-- Нейтральные
(5, 'It is okay, nothing special'),
(6, 'Average quality, acceptable'),
(5, 'The product works as expected');
