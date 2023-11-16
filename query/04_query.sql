SELECT date_trunc('month', order_date)::DATE AS year_month,
		count(DISTINCT order_id) AS total_number_orders,
        sum(freight) as total_freight
        
FROm orders
WHERE to_char(order_date, 'yyyy') IN ('1996','1997')
GROUP BY 1
HAVING count(DISTINCT order_id) > 20  and sum(freight) > 2500
ORDER BY 3 DESC