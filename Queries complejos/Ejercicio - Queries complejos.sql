USE northwind;

# 1. Lista los productos cuyo list_price es mayor que el promedio de su misma categoría. Utiliza una subconsulta. 

SELECT p1.product_name, p1.category, p1.list_price
FROM products p1
WHERE p1.list_price >(
	SELECT AVG(p2.list_price)
	FROM products p2
	WHERE p2.category = p1.category);

# 2. Muestra las empresas (company) de clientes que sí han hecho al menos una orden. Utiliza IN.

SELECT c.company
FROM customers c
WHERE c.id IN (
	SELECT o.customer_id
	FROM orders o);

# 3. Total de órdenes por cliente (muestra company y total_ordenes).

	#Utilizando Join

SELECT c.company, COUNT(o.id) AS total_ordenes
FROM customers c
JOIN orders o
ON o.customer_id = c.id
GROUP BY c.company;

	#Utilizando Subconsulta

SELECT c.company, t.total_ordenes 
FROM customers c 
JOIN (
	SELECT customer_id, COUNT(*) AS total_ordenes 
	FROM orders 
	GROUP BY customer_id 
	) AS t ON t.customer_id = c.id;

# 4. Muestra, por cada proveedor, el producto cuyo list_price es el más alto. Usa el operador ALL para compararlo con los precios de los demás productos del mismo proveedor.

SELECT p.product_name, p.list_price, p.supplier_ids
FROM products p 
WHERE p.list_price > ALL ( 
	SELECT p2.list_price 
	FROM products p2 
	WHERE p2.supplier_ids = p.supplier_ids 
	AND p2.id <> p.id);

/* 
5. Muestra las órdenes cuyo shipping_fee sea mayor que cualquiera de las shipping_fee de 
las órdenes enviadas al estado 'NY' (en la práctica: > ANY ≈ mayor que el mínimo de esa 
lista, es decir, mayor que el mínimo del estado de ‘NY’). Utiliza ANY.
*/

SELECT id, ship_city, ship_state_province, shipping_fee 
FROM orders 
WHERE shipping_fee IS NOT NULL 
AND shipping_fee > ANY ( 
	SELECT o2.shipping_fee 
		FROM orders o2 
	WHERE o2.ship_state_province = 'NY' 
	AND o2.shipping_fee IS NOT NULL);

# 6. Muestra órdenes cuyo shipping_fee sea mayor que el promedio de envío de ese mismo cliente. 

SELECT o.* 
FROM orders o 
WHERE o.shipping_fee > 
(SELECT AVG(o2.shipping_fee) 
FROM orders o2 
WHERE o2.customer_id = o.customer_id);






