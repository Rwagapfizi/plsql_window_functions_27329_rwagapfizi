-- AGGREGATE WINDOW FUNCTIONS: Monthly sales trends with running totals and averages
SELECT 
    order_month,
    monthly_sales,
    -- Running total (unbounded preceding)
    SUM(monthly_sales) OVER (ORDER BY order_month ROWS UNBOUNDED PRECEDING) AS running_total,
    -- 2-month moving average (rows frame)
    AVG(monthly_sales) OVER (
        ORDER BY STR_TO_DATE(CONCAT(order_month, '-01'), '%Y-%m-%d') 
        ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
    ) AS moving_avg_2month,
    -- Monthly min and max in context
    MIN(monthly_sales) OVER (ORDER BY order_month) AS min_to_date,
    MAX(monthly_sales) OVER (ORDER BY order_month) AS max_to_date,
    -- Running average using ROWS frame instead of RANGE
    AVG(monthly_sales) OVER (ORDER BY order_month ROWS UNBOUNDED PRECEDING) AS running_avg
FROM (
    SELECT 
        order_month,
        SUM(total_amount) AS monthly_sales
    FROM ORDERS
    GROUP BY order_month
    ORDER BY order_month
) AS monthly_data;