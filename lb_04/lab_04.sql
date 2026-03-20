-- 1. Ранжирование уникальных клиентов по сумме покупок
SELECT 
    customer_id,
    SUM(sales_amount) as total_sales,
    -- Окно: весь набор данных, сортировка по убыванию суммы
    ROW_NUMBER() OVER (ORDER BY SUM(sales_amount) DESC) as row_number,
    -- Окно: весь набор данных, сортировка по убыванию суммы  
    RANK() OVER (ORDER BY SUM(sales_amount) DESC) as rank,
    -- Окно: весь набор данных, сортировка по убыванию суммы
    DENSE_RANK() OVER (ORDER BY SUM(sales_amount) DESC) as dense_rank
FROM sales
GROUP BY customer_id
ORDER BY total_sales DESC;


-- 2 задание 
-- Сравнение даты найма с датой найма следующего сотрудника в том же дилерском центре
SELECT 
    salesperson_id,
    dealership_id,
    first_name,
    last_name,
    hire_date,
    -- Окно: разбивка по dealership_id, сортировка по hire_date внутри каждого центра
    LEAD(hire_date) OVER (PARTITION BY dealership_id ORDER BY hire_date) as next_hire_date,
    -- Окно: разбивка по dealership_id, сортировка по hire_date внутри каждого центра
    LEAD(first_name) OVER (PARTITION BY dealership_id ORDER BY hire_date) as next_employee_name
FROM salespeople
WHERE termination_date IS NULL
ORDER BY dealership_id, hire_date;


-- 3 задание 
-- Нарастающий итог продаж для каждого типа продукта
SELECT 
    s.sales_transaction_date::DATE as sale_date,
    p.product_type,
    s.sales_amount,
    -- Окно: разбивка по product_type, сортировка по дате, 
    -- фрейм: от начала партиции до текущей строки
    SUM(s.sales_amount) OVER (
        PARTITION BY p.product_type 
        ORDER BY s.sales_transaction_date
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) as running_total_by_type
FROM sales s
JOIN products p ON s.product_id = p.product_id
ORDER BY p.product_type, s.sales_transaction_date;
