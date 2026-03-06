-- ЗАДАНИЕ 1.1
SELECT *
FROM sales
ORDER BY sales_amount DESC
LIMIT 20;

-- ЗАДАНИЕ 1.2
SELECT *
FROM dealerships
WHERE state = 'CA';

-- ЗАДАНИЕ 1.3

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'salespeople'
ORDER BY ordinal_position;

CREATE TABLE recent_hires AS
SELECT *
FROM salespeople
WHERE hire_date >= '2019-01-01';

SELECT *
FROM recent_hires;

UPDATE recent_hires
SET title = 'Junior'

DELETE FROM recent_hires
WHERE termination_date IS NOT NULL
   OR FALSE; 


