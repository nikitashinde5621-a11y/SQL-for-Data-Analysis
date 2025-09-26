-- Task 4: SQL for Data Analysis

-- 1. Basic SELECT
SELECT customer_id, name, city, country 
FROM customers
WHERE country = 'India';

-- 2. Orders in 2025 sorted by amount
SELECT order_id, customer_id, total_amount, order_date
FROM orders
WHERE YEAR(order_date) = 2025
ORDER BY total_amount DESC;

-- 3. Total sales by country
SELECT c.country, SUM(o.total_amount) AS total_sales
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.country
ORDER BY total_sales DESC;

-- 4. Average order value
SELECT AVG(total_amount) AS avg_order_value
FROM orders;

-- 5. Customer orders with JOIN
SELECT c.name, o.order_id, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;

-- 6. Products with no orders
SELECT p.product_name
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.product_id IS NULL;

-- 7. Subquery: Customers who spent more than average
SELECT name, customer_id
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    GROUP BY customer_id
    HAVING SUM(total_amount) > (SELECT AVG(total_amount) FROM orders)
);

-- 8. Create view for monthly sales
CREATE VIEW monthly_sales AS
SELECT MONTH(order_date) AS month, YEAR(order_date) AS year, SUM(total_amount) AS total_sales
FROM orders
GROUP BY YEAR(order_date), MONTH(order_date);

-- 9. Query the view
SELECT * FROM monthly_sales WHERE year = 2025;

-- 10. Indexes
CREATE INDEX idx_customer_id ON orders(customer_id);
CREATE INDEX idx_product_id ON order_items(product_id);
