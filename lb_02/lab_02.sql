-- 1 задание  Запрос для получения списка дилеров (городов) и сотрудников-мужчин
SELECT 
    d.city AS "Город дилера",                    -- Название города из таблицы dealerships
    sp.first_name || ' ' || sp.last_name AS "Имя сотрудника"  -- Конкатенация имени и фамилии
FROM 
    dealerships d                                  -- Левая таблица - дилеры (псевдоним d)
INNER JOIN 
    salespeople sp ON d.dealership_id = sp.dealership_id  -- Соединение по ID дилера
WHERE 
    sp.gender = 'Male'                             -- Фильтр только для мужчин
    AND (sp.termination_date IS NULL                -- Исключаем уволенных сотрудников
         OR sp.termination_date > CURRENT_DATE)
ORDER BY 
    d.city, sp.last_name;                           -- Сортировка по городу и фамилии




-- 2 задание Объединяем имена и считаем, сколько раз каждое имя встречается в каждой категории
SELECT 
    first_name AS "Имя",
    COUNT(CASE WHEN source = 'Клиент' THEN 1 END) AS "Клиентов",
    COUNT(CASE WHEN source = 'Сотрудник' THEN 1 END) AS "Сотрудников",
    COUNT(*) AS "Всего"
FROM (
    -- Подзапрос: берем имена клиентов с пометкой 'Клиент'
    SELECT first_name, 'Клиент' AS source FROM customers
    
    UNION ALL
    
    -- И имена сотрудников с пометкой 'Сотрудник'
    SELECT first_name, 'Сотрудник' AS source FROM salespeople
) AS combined_names
GROUP BY first_name
ORDER BY "Всего" DESC, first_name;


-- 3 задание

SELECT 
    s.customer_id,
    s.product_id,
    s.sales_transaction_date,
    s.sales_amount,
    p.base_msrp,
    
    -- Используем NULLIF для защиты от деления на 0
    -- COALESCE заменяет NULL на 0
    COALESCE(
        ROUND(((p.base_msrp - s.sales_amount) / NULLIF(p.base_msrp, 0) * 100)::NUMERIC, 2),
        0
    ) AS discount_percent
    
FROM sales s
LEFT JOIN products p ON s.product_id = p.product_id
WHERE s.sales_amount IS NOT NULL
LIMIT 50;  -- ограничим вывод для проверки
