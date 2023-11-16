SELECT concat(first_name, ' ', last_name) employee_full_name,
	title employee_title, 
    total_sale_amount_excluding_discount,
    number_of_unique_orders,
    number_of_orders,
    average_order_amount,
    total_discount_amount,
    total_discount_percentage
FROm employees 

JOIN 

(SELECT  employee_id, 
 	SUM(unit_price * (1-discount) * quantity) total_sale_amount_excluding_discount, 
 	COUNT(DISTINCT o.order_id) number_of_unique_orders, 
 	count(order_id) number_of_orders, 
 	AVG(unit_price * (1-discount) * quantity) average_order_amount, 
 	SUM(unit_price * discount * quantity) total_discount_amount, 
 	SUM(unit_price  * quantity) total_sale_amount_including_discount, 
 	SUM(unit_price * discount * quantity) / SUM(unit_price  * quantity) total_discount_percentage
 
FROM order_details
JOIN orders o
USING (order_id)
GROUP BY 1) A
USING (employee_id)
