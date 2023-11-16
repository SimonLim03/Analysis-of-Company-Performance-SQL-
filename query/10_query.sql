SELECT category_name,
	concat(first_name, ' ', last_name) employee_full_name,
    total_sale_amount,
    total_sale_amount/ SUM(total_sale_amount) OVER (PARTITION BY category_name) percentage_of_category_sales, 
    total_sale_amount/ SUM(total_sale_amount) OVER (PARTITION BY employee_id) percentage_of_employee_sales
FROm employees 

JOIN 

(SELECT  employee_id,
 		category_name,
 	SUM(od.unit_price  * quantity) total_sale_amount
 
FROM order_details od
JOIN orders o
USING (order_id)
 JOIN products
 USING(product_id)
JOIN categories
USING(category_id)
GROUP BY 1, 2) A
USING (employee_id)