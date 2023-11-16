SELECT * 
FROM

(SELECT ship_country as shipping_country, 
		ROUND(AVG(shipped_date::DATE - order_date::DATE),2) AS average_days_between_order_shipping, 
        count(distinct order_id) AS total_volume_orders

FROM orders
where TO_CHAR(order_date, 'YYYY')='1997'
 GROUP BY 1
) a
WHERE average_days_between_order_shipping >= 3 and average_days_between_order_shipping < 20 and total_volume_orders > 5

ORDER BY 2 DESC