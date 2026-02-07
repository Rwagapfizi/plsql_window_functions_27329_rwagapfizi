-- Simulating FULL OUTER JOIN: All customers and products with their relationships
SELECT 
    'Customer' AS record_type,
    c.customer_id AS id,
    CONCAT(c.first_name, ' ', c.last_name) AS name,
    r.region_name AS location,
    COUNT(o.order_id) AS order_count,
    COALESCE(SUM(o.total_amount), 0) AS total_value
FROM CUSTOMER c
LEFT JOIN ORDERS o ON c.customer_id = o.customer_id
LEFT JOIN REGION r ON c.region_id = r.region_id
GROUP BY c.customer_id, c.first_name, c.last_name, r.region_name

UNION ALL

SELECT 
    'Product' AS record_type,
    p.product_id AS id,
    p.product_name AS name,
    p.category AS location,
    COUNT(od.order_detail_id) AS order_count,
    COALESCE(SUM(od.line_total), 0) AS total_value
FROM PRODUCT p
LEFT JOIN ORDER_DETAIL od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name, p.category

ORDER BY record_type, total_value DESC;