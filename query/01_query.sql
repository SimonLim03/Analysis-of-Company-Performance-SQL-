SELECT product_name, unit_price
FROM products
WHERE  (unit_price BETWEEN 10 and 50) AND discontinued = 0
ORDER BY 1 