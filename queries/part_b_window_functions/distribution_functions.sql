-- DISTRIBUTION FUNCTIONS: Customer segmentation into quartiles and cumulative distribution
SELECT 
    customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    region_name,
    total_purchases,
    -- Segment customers into 4 quartiles based on spending
    NTILE(4) OVER (ORDER BY total_purchases DESC) AS spending_quartile,
    -- Cumulative distribution (percentage of customers with equal or less spending)
    ROUND(CUME_DIST() OVER (ORDER BY total_purchases DESC) * 100, 2) AS cume_dist_pct,
    -- Decile segmentation for finer granularity
    NTILE(10) OVER (ORDER BY total_purchases DESC) AS spending_decile,
    CASE 
        WHEN NTILE(4) OVER (ORDER BY total_purchases DESC) = 1 THEN 'Premium'
        WHEN NTILE(4) OVER (ORDER BY total_purchases DESC) = 2 THEN 'Gold'
        WHEN NTILE(4) OVER (ORDER BY total_purchases DESC) = 3 THEN 'Silver'
        ELSE 'Bronze'
    END AS customer_tier
FROM CUSTOMER c
JOIN REGION r ON c.region_id = r.region_id
ORDER BY total_purchases DESC;