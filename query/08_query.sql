SELECT category_name, 
	product_name, 
	unit_price, 
	median_per_category, 
	AVG(unit_price) OVER (PARTITION BY category_name)	 average_unit_price, 
    CASE WHEN unit_price < AVG(unit_price) OVER (PARTITION BY category_name)
     THEN 'Below Average'
      ELSE 'Over Average' END average_unit_price_position, 
      CASE WHEN unit_price < median_per_category
       THEN 'Below Median'
       ELSE 'Over Median' END median_unit_price_position
FROM 
(SELECT category_id, 
        --AVG(unit_price) OVER (PARTITION BY category_name), 
        PERCENTILE_DISC(0.5) WITHIN GROUP (ORDER BY unit_price) median_per_category--, 
        --CASE WHEN unit_price < AVG(unit_price) OVER (PARTITION BY category_name)
        --THEN 'Below Average'
        --ELSE 'Over Average' END average_unit_price_position--, 
        --CASE WHEN unit_price < PERCENTILE_CONT(unit_price, 0.5) OVER (PARTITION BY category_name)
        --THEN 'Below Median'
        --ELSE 'Over Median' END median_unit_price_position
FROM products 
JOIN categories 
USING(category_id)
GROUP BY category_id) a
JOIN products
USING(category_id)
JOIN categories
USING(category_id)
