
# Практическая работа №1  
## Геопространственный анализ данных. Аналитика с использованием сложных типов данных.
---

## Цель работы
Научиться применять продвинутые возможности PostgreSQL для анализа данных, выходящих за рамки стандартных чисел и строк. Освоить работу с временными рядами, геопространственными данными, массивами, JSON/JSONB структурами и полнотекстовым поиском.

---

# 🔹 Задача 1. Дни недели продаж

## Условие  
Определите, в какой день недели (понедельник, вторник и т.д.) совершается наибольшее количество продаж (sales). Выведите день недели и количество транзакций.

---

##  SQL-код
```sql
SELECT 
    TO_CHAR(sales_transaction_date, 'Day') AS day_name,
    COUNT(*) AS total_sales
FROM sales
GROUP BY day_name
ORDER BY total_sales DESC;
````

---

## Скриншот результата

<img width="337" height="325" alt="image" src="https://github.com/user-attachments/assets/2853154c-b186-45c6-aef9-2c0ae974cad4" />


---

## Вывод

В результате запроса определяется день недели с максимальным количеством продаж.
Функция `TO_CHAR` используется для преобразования даты в название дня недели, а `COUNT(*)` позволяет подсчитать количество транзакций.

---

# Задача 2. Ближайший дилер

##  Условие

Ближайший дилер. Для каждого клиента из города 'New York City' найдите ближайший дилерский центр (dealerships) и расстояние до него.

## SQL-код

```sql
SELECT 
    c.customer_id,
    d.dealership_id,
    MIN(point(c.longitude, c.latitude) <@> point(d.longitude, d.latitude)) AS min_distance
FROM customers c
JOIN dealerships d ON TRUE
WHERE c.city = 'New York City'
GROUP BY c.customer_id, d.dealership_id
ORDER BY c.customer_id, min_distance;
```

---

## 📸 Скриншот результата

<img width="562" height="432" alt="image" src="https://github.com/user-attachments/assets/66b170dc-de46-4067-bae4-6d3b215ff092" />

---

##  Вывод

В ходе выполнения запроса рассчитывается расстояние между клиентами и дилерскими центрами с использованием геопространственных функций PostgreSQL.
Оператор `<@>` вычисляет расстояние между координатами.
Запрос позволяет определить ближайший дилерский центр для клиентов.

---

# Задача 3. Поиск негативных отзывов

## Условие

Поиск негатива. Найдите все отзывы, содержащие слова с корнем 'bad', 'fail', 'poor' (используйте to_tsvector и plainto_tsquery или ILIKE).

---

## SQL-код

```sql
SELECT *
FROM customer_survey
WHERE 
    to_tsvector('english', feedback) @@ 
    to_tsquery('english', 'bad:* | fail:* | poor:*');
```

---

## Особенность выполнения

Изначально в таблице `customer_survey` отсутствовали данные, содержащие слова с корнями `bad`, `fail`, `poor`.
Из-за этого запрос не возвращал результатов.

Для корректной демонстрации работы полнотекстового поиска были добавлены тестовые данные, содержащие как негативные, так и позитивные отзывы.

---

## Добавленные данные

```sql
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
```

---

## 📸 Скриншот результата

<img width="552" height="295" alt="image" src="https://github.com/user-attachments/assets/f0f56d3f-b6e1-403d-be95-92280943404a" />


---

## Вывод

После добавления тестовых данных запрос успешно находит негативные отзывы.
Использование `to_tsvector` и `to_tsquery` позволяет выполнять поиск по корням слов, что делает анализ более гибким и эффективным по сравнению с обычным поиском через `LIKE`.

---

# 📄 Файлы проекта

* `practical_work_01.sql` — SQL-скрипты всех выполненных заданий

---

# Вывод
Были получены навыки применять продвинутые возможности PostgreSQL для анализа данных, выходящих за рамки стандартных чисел и строк. Освоена работа с временными рядами, геопространственными данными, массивами, JSON/JSONB структурами и полнотекстовым поиском.
