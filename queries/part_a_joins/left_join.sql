-- LEFT JOIN: Show all customers with their purchase summary
SELECT 
    c.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    r.region_name,
    c.district,
    COUNT(o.order_id) AS total_orders,
    COALESCE(SUM(o.total_amount), 0) AS total_spent,
    CASE 
        WHEN COUNT(o.order_id) > 0 THEN 'Active'
        ELSE 'Inactive'
    END AS status
FROM CUSTOMER c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
LEFT JOIN REGION r ON c.region_id = r.region_id
GROUP BY c.customer_id, c.first_name, c.last_name, r.region_name, c.district
ORDER BY total_spent DESC;