SELECT product_name, 
	previous_unit_price, 
    current_price, 
    ((current_price/previous_unit_price) -1) * 100.00 AS percentage_increase
FROM
(SELECT DISTINCT product_id, 
 FIRST_VALUE(unit_price) OVER (PARTITION BY product_id ORDER BY order_date) previous_unit_price , 
 LAST_VALUE(unit_price) OVER (PARTITION BY product_id ORDER BY order_date) current_price
FROm orders
LEFT JOIN order_details
USING(order_id) ) a
JOIN products
ON a.product_id = products.product_id
WHERE (current_price/previous_unit_price) -1 < 0.1 OR (current_price/previous_unit_price) -1 > 0.3

ORDER BY 4 DESC
--GROUP BY 1