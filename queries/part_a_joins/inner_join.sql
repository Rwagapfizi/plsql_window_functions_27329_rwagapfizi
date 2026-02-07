-- INNER JOIN: Get complete order details with customer and product information
SELECT 
    o.order_id,
    DATE_FORMAT(o.order_date, '%d-%b-%Y') AS order_date,
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    c.district AS customer_district,
    p.product_name,
    p.category,
    od.quantity,
    od.unit_price,
    od.line_total,
    r.region_name
FROM ORDERS o
INNER JOIN CUSTOMER c ON o.customer_id = c.customer_id
INNER JOIN ORDER_DETAIL od ON o.order_id = od.order_id
INNER JOIN PRODUCT p ON od.product_id = p.product_id
INNER JOIN REGION r ON c.region_id = r.region_id
ORDER BY o.order_date, o.order_id;