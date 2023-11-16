SELECT categories.category_name, 
		region AS supplier_region,
        SUM(units_in_stock) units_in_stock, 
        SUM(units_on_order) units_on_order, 
        SUM(reorder_level) reorder_level
FROM products
JOIN order_details 
USING (product_id)
JOIN categories 
USING (category_id) 
JOIN suppliers
USING (supplier_id)
GROUP BY 1, 2
ORDER BY 1, 2, 5