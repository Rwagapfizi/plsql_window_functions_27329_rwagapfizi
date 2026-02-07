-- RANKING FUNCTIONS: Compare different ranking methods for products by revenue
SELECT 
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(od.line_total), 0) AS total_revenue,
    COUNT(od.order_detail_id) AS sales_count,
    -- Different ranking methods
    ROW_NUMBER() OVER (ORDER BY COALESCE(SUM(od.line_total), 0) DESC) AS row_num,
    RANK() OVER (ORDER BY COALESCE(SUM(od.line_total), 0) DESC) AS rank_pos,
    DENSE_RANK() OVER (ORDER BY COALESCE(SUM(od.line_total), 0) DESC) AS dense_rank_pos,
    PERCENT_RANK() OVER (ORDER BY COALESCE(SUM(od.line_total), 0) DESC) AS percent_rank
FROM PRODUCT p
LEFT JOIN ORDER_DETAIL od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name, p.category
ORDER BY total_revenue DESC;