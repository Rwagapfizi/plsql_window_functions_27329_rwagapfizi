-- SELF JOIN: Compare customers within the same region
SELECT 
    r.region_name,
    c1.customer_id AS cust1_id,
    CONCAT(c1.first_name, ' ', c1.last_name) AS cust1_name,
    c1.total_purchases AS cust1_total,
    c2.customer_id AS cust2_id,
    CONCAT(c2.first_name, ' ', c2.last_name) AS cust2_name,
    c2.total_purchases AS cust2_total,
    ROUND(c1.total_purchases - c2.total_purchases, 2) AS spending_difference
FROM CUSTOMER c1
INNER JOIN CUSTOMER c2 ON c1.region_id = c2.region_id AND c1.customer_id < c2.customer_id
INNER JOIN REGION r ON c1.region_id = r.region_id
ORDER BY r.region_name, spending_difference DESC;