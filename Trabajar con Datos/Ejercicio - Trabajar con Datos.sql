#Para estos ejercicios practicos se utilizo la BD_Northwind
USE northwind;

#Ejercicio 2 Actualiza el nombre del contacto (first_name) del cliente con id = 6 a 'Luis'.

SELECT 
		c.id,
		c.first_name
FROM customers c
ORDER BY c.id ASC;

UPDATE customers c
SET c.first_name="Luis"
WHERE c.id = 6;

#Ejercicio 3 Simula que el empleado Jan, quien actualmente tiene el puesto de 'Sales Representative', ha sido ascendido a 'Sales Manager'.

SELECT *
FROM employees
WHERE first_name = "Jan";

UPDATE employees
SET job_title = "Sales Manager"
WHERE first_name = "Jan";

/*
Ejercicio 4 Los proveedores no tienen registrado el estado (state_province) en el que se encuentran.
Ingresa los siguientes datos manualmente en la tabla suppliers:
• Supplier A | NY        
• Supplier B | CA
• Supplier C | NY
• Supplier D | TX        
• Supplier E | TX             
• Supplier F | WA             
• Supplier G | CA             
• Supplier H | WA           
• Supplier I | NY             
• Supplier J | TX
*/

SELECT 
		company,
		state_province
FROM suppliers;

UPDATE suppliers SET state_province = "NY" WHERE company = "Supplier A";
UPDATE suppliers SET state_province = "CA" WHERE company = "Supplier B";
UPDATE suppliers SET state_province = "NY" WHERE company = "Supplier C";
UPDATE suppliers SET state_province = "TX" WHERE company = "Supplier D";
UPDATE suppliers SET state_province = "TX" WHERE company = "Supplier E";
UPDATE suppliers SET state_province = "WA" WHERE company = "Supplier F";
UPDATE suppliers SET state_province = "CA" WHERE company = "Supplier G";
UPDATE suppliers SET state_province = "WA" WHERE company = "Supplier H";
UPDATE suppliers SET state_province = "NY" WHERE company = "Supplier I";
UPDATE suppliers SET state_province = "TX" WHERE company = "Supplier J";

#Ejercicio 5 Crea una nueva tabla products_backup con todos los productos. 

CREATE TABLE products_backup AS
SELECT *
FROM products;

/*
Ejercicio 6 Ahora que ya se completaron los estados, la empresa desea ofrecer un descuento en costos
de producción a los productos cuyos proveedores estén ubicados en el estado de New York
(NY). Reduce en un 10% el standard_cost de todos los productos cuyo proveedor
(suppliers) esté ubicado en el estado 'NY'
*/

SELECT 
		company,
		product_name,
		state_province,
		standard_cost
FROM products p
JOIN suppliers s
	ON p.supplier_ids = s.id
WHERE s.state_province
= "NY";

UPDATE products p
JOIN suppliers s ON p.supplier_ids = s.id
SET p.standard_cost = p.standard_cost * .9
WHERE s.state_province = 'NY';

#Ejercicio 7 Aumenta el list_price en 5% para todos los productos de la categoría 'Beverages' que tengan minimum_reorder_quantity mayor o igual a 25. 

SELECT 
		product_name,
		category,
		minimum_reorder_quantity,
		list_price
FROM products
WHERE category = "Beverages" and minimum_reorder_quantity >= 25;

UPDATE products
SET list_price = list_price * 1.05
WHERE category = "Beverages" and minimum_reorder_quantity >= 25;

#Ejercicio 8 Actualiza el campo taxes de la tabla orders, asignándole un 16% del shipping_fee solo a los pedidos cuyo shipping_fee sea mayor al promedio general de todos los pedidos.

SELECT 
		id,
		ship_name,
		shipping_fee,
		taxes
FROM orders

UPDATE orders
JOIN (
    SELECT AVG(shipping_fee) AS avg_shipping
    FROM orders
) AS avg_table
SET taxes = shipping_fee * 0.16
WHERE shipping_fee > avg_table.avg_shipping;

SELECT AVG(shipping_fee) AS avg_shipping
FROM orders;

#Ejercicio 9 Elimina los productos que han sido descontinuados (discontinued = 1) y que no aparecen en ninguna línea de pedido (order_details).

SELECT *
FROM products
WHERE discontinued = 1

DELETE FROM products
WHERE discontinued = 1
AND id NOT IN (
    SELECT DISTINCT product_id
    FROM order_details
  );

#Ejercicio 10 Un proveedor desea ajustar sus precios en función del volumen de ventas. Actualiza el list_price de cada producto incrementándolo en un 5% si ese producto ha vendido más de 100 unidades en total (sumando todas las órdenes en order_details).

SELECT p.id, p.product_name, p.list_price, ventas.total_vendido
FROM products p
JOIN (
    SELECT product_id, SUM(quantity) AS total_vendido
    FROM order_details
    GROUP BY product_id
    HAVING total_vendido > 100
) AS ventas 
ON p.id = ventas.product_id;
 
UPDATE products p
JOIN (
    SELECT product_id, SUM(quantity) AS total_vendido
    FROM order_details
    GROUP BY product_id
    HAVING total_vendido > 100
) AS ventas ON p.id = ventas.product_id
SET p.list_price = p.list_price * 1.05;