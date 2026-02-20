#Para estos ejercicios practicos se utilizo la BD_Northwind
USE northwind;

#Ejercicio 1 Muestra el nombre del producto y el nombre del proveedor correspondiente para todos los productos activos (no descontinuados).

SELECT 
		p.product_name,
		s.company as supplier_company,
		p.discontinued
FROM products p
JOIN suppliers s
	ON p.supplier_ids = s.id
WHERE p.discontinued = 0;
	
#Ejercicio 2 Muestra el nombre del producto, su categoría y el proveedor solo si su precio de lista es mayor a 20 y pertenece a las categorías 'Condiments' o 'Candy'.

SELECT 
		p.product_name,
		p.category,
		s.company as supplier_company,
		p.list_price
FROM products p
JOIN suppliers s
	ON p.supplier_ids = s.id
WHERE p.list_price >20 AND p.category IN("Condiments", "Candy");

#Ejercicio 3 Selecciona el nombre de la empresa del cliente y el id de las órdenes y filtra únicamente aquellas empresas cuyo nombre empiece con la letra 'C'.

SELECT 
		c.company AS customer_company,
		o.id AS order_id
FROM customers c
JOIN orders o
	ON 	c.id = o.customer_id
WHERE c.company LIKE ("C%");

#Ejercicio 4 Muestra los pares de empleados que trabajan en la misma ciudad. Evita mostrar combinaciones repetidas o un empleado comparado consigo mismo. Ordena el resultado por el nombre del primer empleado.

SELECT 
		e.last_name,
		e.first_name,
		f.last_name,
		f.first_name,
		e.city
FROM employees e
JOIN employees f
	ON e.city = f.city AND e.id < f.id
ORDER BY e.first_name;


#Ejercicio 5 Lista todos los productos y su proveedor si tienen uno. Si no tienen proveedor asignado, indica 'SIN PROVEEDOR'. 

SELECT 
		p.product_name,
		COALESCE(s.company, "SIN PROVEEDOR") AS supplier_company 
FROM products p 
LEFT JOIN suppliers s 
	ON p.supplier_ids = s.id;

#Ejercicio 6 Muestra todos los proveedores, incluyendo aquellos que no tienen productos asociados.

SELECT 
		s.company AS supplier_company,
		p.product_name
FROM suppliers s
LEFT JOIN products p 
	ON s.id = p.supplier_ids;

#Ejercicio 7 Genera combinaciones de productos con proveedores para explorar posibles asignaciones. Limita el resultado a 20. 

SELECT 
		p.product_name, 
		s.company AS supplier_company
 FROM products p
 CROSS JOIN suppliers s
 LIMIT 20; 

#Ejercicio 8 Muestra clientes localizados en los estados NY o MN. Evita duplicados.

SELECT company, state_province
 FROM customers
 WHERE state_province = 'NY'
 UNION
 SELECT company, state_province
 FROM customers
 WHERE state_province = 'MN';


#Ejercicio 9 Muestra el nombre del producto, su precio y la cantidad pedida en cada línea de pedido.

SELECT 
		p.product_name,
		p.list_price,
		od.quantity
FROM products p
JOIN order_details od
	ON p.id = od.product_id;

#Ejercicio 10 Muestra el nombre del cliente, el ID del pedido y el empleado que gestionó el pedido.

SELECT 
		c.company AS cliente,
		o.id AS order_id,
		e.first_name AS empleado
FROM orders o
JOIN employees e
	ON o.employee_id = e.id
JOIN customers c 
	ON o.customer_id = c.id;