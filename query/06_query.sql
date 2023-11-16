SELECT category_name, 
	CASE WHEN o.unit_price < 10 THEN '1. BELOW $10' 
    WHEN o.unit_price <= 20 THEN '2. $10 - $20' 
    WHEN o.unit_price <= 50 THEN '3. $20 - $50' 
    ELSE '4. OVER $50' 
     END AS price_range, 
     ROUND(SUM(o.unit_price *(1-discount))) total_amount, 
     SUM(order_id) AS total_number_orders
FROM products prod
JOIN categories cate
USING (category_id)
JOIN order_details o
USING (product_id)
GROUP BY 1,2 
ORDER BY 1, 2