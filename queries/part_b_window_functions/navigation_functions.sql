-- NAVIGATION FUNCTIONS: Month-over-month sales comparison and growth rates
SELECT 
    order_month,
    monthly_sales,
    -- Previous month's sales
    LAG(monthly_sales, 1) OVER (ORDER BY order_month) AS prev_month_sales,
    -- Next month's sales
    LEAD(monthly_sales, 1) OVER (ORDER BY order_month) AS next_month_sales,
    -- Month-over-month change
    monthly_sales - LAG(monthly_sales, 1) OVER (ORDER BY order_month) AS mom_change,
    -- Month-over-month growth percentage
    ROUND(
        (monthly_sales - LAG(monthly_sales, 1) OVER (ORDER BY order_month)) / 
        LAG(monthly_sales, 1) OVER (ORDER BY order_month) * 100, 
        2
    ) AS mom_growth_pct
FROM (
    SELECT 
        order_month,
        SUM(total_amount) AS monthly_sales
    FROM ORDERS
    GROUP BY order_month
    ORDER BY order_month
) AS monthly_data;