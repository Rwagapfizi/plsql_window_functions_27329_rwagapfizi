-- RIGHT JOIN: Show all products with their sales performance
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    COUNT(od.order_detail_id) AS times_sold,
    COALESCE(SUM(od.quantity), 0) AS total_quantity_sold,
    COALESCE(SUM(od.line_total), 0) AS total_revenue
FROM ORDER_DETAIL od
RIGHT JOIN PRODUCT p ON od.product_id = p.product_id
GROUP BY p.product_id, p.product_name, p.category, p.price
ORDER BY total_revenue DESC;