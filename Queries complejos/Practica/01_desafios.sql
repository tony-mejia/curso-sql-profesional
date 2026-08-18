-- ============================================================================
--  PRACTICA: Queries Complejos (Capítulo 6)
--  Archivo: 01_desafios.sql  (TUS DESAFÍOS — sin respuestas)
--  Dominio: tienda de electrónica "ElectroHub" (esquema espejo de Northwind)
--
--  CÓMO USAR ESTO:
--  1) Ejecutá primero  00_setup.sql  (crea la base `practica_queries` con datos).
--  2) Antes de cada desafío, poné `USE practica_queries;` (o seleccionala).
--  3) Leé la pregunta de negocio y escribí TU consulta en el espacio indicado.
--  4) Verificá con el AUTOCHECK (cantidad de filas) sin espiar el contenido.
--  5) SOLO al final (o si te trabás mucho), mirá 02_respuestas.sql.
--
--  Tablas: products | customers | orders | order_details | suppliers
-- ============================================================================

USE practica_queries;

-- ============================================================================
--  TRUCO DE AUTOCHECK (leelo UNA vez)
-- ----------------------------------------------------------------------------
--  Para saber si tu consulta devuelve la cantidad correcta de filas SIN ver el
--  contenido, envolvete tu SELECT en un COUNT. Ejemplo:
--
--      SELECT COUNT(*)
--      FROM (  <-- acá pegás tu SELECT completo -->  ) AS t;
--
--  El número que devuelva tiene que coincidir con el AUTOCHECK del desafío.
--  Esto te confirma que vas bien, sin darte la respuesta.
-- ============================================================================


-- ============================================================================
--  DESAFÍO 1 — Subconsulta correlacionada (comparación contra el promedio)
--  Concepto: subconsulta que depende de la fila actual de la consulta externa.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "Marketing quiere saber qué productos tienen un precio de lista (list_price)
--   MAYOR al promedio de SU PROPIA categoría."
--
--  Mostrá: product_name, category, list_price
--  AUTOCHECK: 10 filas.
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

SELECT
	product_name,
	category,
	list_price
FROM products p
WHERE list_price > (
	SELECT AVG(list_price)
	FROM products p2
	WHERE p2.category = p.category);

-- ▲▲▲ FIN ▲▲▲



-- ============================================================================
--  DESAFÍO 2 — Operador IN con subconsulta
--  Concepto: IN compara contra una LISTA que devuelve una subconsulta.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "Ventas quiere la lista de empresas (company) de los clientes que SÍ han
--   hecho al menos una orden."
--
--  Mostrá: company
--  AUTOCHECK: 10 filas.
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

SELECT
	company
FROM customers
WHERE id IN (SELECT DISTINCT customer_id FROM orders);

-- ▲▲▲ FIN ▲▲▲


-- ============================================================================
--  DESAFÍO 3 — JOIN vs subconsulta en FROM (total de órdenes por cliente)
--  Concepto: resolver lo mismo de DOS formas distintas y entender la diferencia.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "Quiero un reporte con cada cliente y su CANTIDAD TOTAL de órdenes."
--
--  3A) Resolvelo usando JOIN + GROUP BY.
--  3B) Resolvelo usando una subconsulta en el FROM (tabla derivada).
--
--  Mostrá: company, total_ordenes
--  AUTOCHECK: 10 filas (en ambos casos).
-- ============================================================================

-- ▼▼▼ 3A — ESCRIBÍ TU CONSULTA CON JOIN ▼▼▼

SELECT 
	c.company,
	COUNT(o.id) AS total_ordenes
FROM customers c
JOIN orders o
ON c.id = o.customer_id
GROUP BY c.company;

-- ▲▲▲ FIN 3A ▲▲▲


-- ▼▼▼ 3B — ESCRIBÍ TU CONSULTA CON SUBCONSULTA EN FROM ▼▼▼

SELECT 
	c.company, 
	t.total_ordenes
FROM customers c
JOIN (
    SELECT customer_id, COUNT(*) AS total_ordenes
    FROM orders
    GROUP BY customer_id
) AS t ON t.customer_id = c.id;

-- ▲▲▲ FIN 3B ▲▲▲


-- ============================================================================
--  DESAFÍO 4 — Operador ALL
--  Concepto: condición verdadera solo si se cumple para TODOS los valores.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "¿Cuáles son los productos cuyo list_price es mayor que TODOS los demás
--   productos de su MISMO proveedor? (los 'producto estrella' de cada proveedor)"
--
--  Mostrá: product_name, list_price, supplier_ids
--  AUTOCHECK: 6 filas.
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

SELECT 
	p.product_name,
	p.list_price,
	p.supplier_ids
FROM products p
WHERE p.list_price > ALL(
	SELECT p2.list_price  
	FROM products p2
	WHERE p2.supplier_ids = p.supplier_ids AND p2.id <> p.id);

-- ▲▲▲ FIN ▲▲▲


-- ============================================================================
--  DESAFÍO 5 — Operador ANY
--  Concepto: condición verdadera si se cumple para AL MENOS UNO de los valores.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "Logística quiere ver las órdenes cuyo costo de envío (shipping_fee) es
--   MAYOR que CUALQUIERA de los envíos de las órdenes enviadas a New York (NY)."
--
--  Mostrá: id, ship_city, ship_state_province, shipping_fee
--  AUTOCHECK: 10 filas.
--  Pista conceptual (no es la respuesta): > ANY equivale a "mayor que el MÍNIMO".
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

SELECT 
	o.id, 
	o.ship_city, 
	o.ship_state_province, 
	o.shipping_fee
FROM orders o
WHERE shipping_fee > ANY(
	SELECT o2.shipping_fee
	FROM orders o2
	WHERE o2.ship_state_province = "NY");

-- ▲▲▲ FIN ▲▲▲


-- ============================================================================
--  DESAFÍO 6 — Subconsulta correlacionada (envío vs promedio de su cliente)
--  Concepto: comparar cada fila contra el promedio de SU PROPIO grupo.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "Quiero todas las órdenes cuyo shipping_fee es mayor que el promedio de
--   envío de ESE MISMO cliente."
--
--  Mostrá: todos los campos de orders (*)
--  AUTOCHECK: 14 filas.
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

	SELECT *
	FROM orders o
	WHERE shipping_fee >(
		SELECT AVG(o2.shipping_fee)
		FROM orders o2
		WHERE o2.customer_id = o.customer_id);

-- ▲▲▲ FIN ▲▲▲


-- ============================================================================
--  DESAFÍO 7 — EXISTS / NOT EXISTS
--  Concepto: comprobar si una subconsulta devuelve al menos una fila.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "El dueño quiere liquidar el stock muerto: ¿qué productos NUNCA han sido
--   vendidos (es decir, no aparecen en order_details)?"
--
--  Mostrá: id, product_name
--  AUTOCHECK: 6 filas.
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

SELECT 
	p.id,
	p.product_name
FROM products p
WHERE NOT EXISTS(
	SELECT 1
	FROM order_details o
	WHERE o.product_id = p.id);

-- ▲▲▲ FIN ▲▲▲


-- ============================================================================
--  DESAFÍO 8 — Subconsultas escalares en el SELECT
--  Concepto: una subconsulta en el SELECT que devuelve UN solo valor por fila.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "Para CADA cliente (todos), mostrá su company, su número total de órdenes y
--   la suma total de shipping_fee."
--
--  Mostrá: company, total_ordenes, total_envio
--  AUTOCHECK: 12 filas (OJO: incluye clientes sin órdenes — mirá qué valor te da).
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

SELECT 
	company,
	(SELECT COUNT(customer_id) FROM orders o WHERE o.customer_id = c.id) AS total_ordenes,
	(SELECT SUM(o.shipping_fee) FROM orders o WHERE o.customer_id = c.id) AS total_envio
FROM customers c;

-- ▲▲▲ FIN ▲▲▲


-- ============================================================================
--  DESAFÍO 9 — Subconsulta en FROM (tabla derivada) + promedio global
--  Concepto: usar el resultado de una consulta como tabla, y filtrarla.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "Quiero el total de unidades vendidas por producto, pero SOLO los productos
--   cuyo total está POR ENCIMA del promedio global de unidades por producto."
--
--  Mostrá: product_name, total_unidades
--  AUTOCHECK: 7 filas.
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

SELECT 
	product_name, v.total_unidades _unidades
FROM (
	SELECT SUM(quantity) AS total_unidades, product_id
	FROM order_details 
	GROUP BY product_id) AS v
JOIN products p
ON p.id = v.product_id
WHERE v.total_unidades >(
	SELECT AVG(t.total_unidades)
	FROM (
        SELECT SUM(quantity) AS total_unidades
        FROM order_details
        GROUP BY product_id
    ) AS t);

-- ▲▲▲ FIN ▲▲▲


-- ============================================================================
--  DESAFÍO 10 — EXISTS + correlación (combo final)
--  Concepto: unir varias tablas dentro de EXISTS, correlacionado con la externa.
-- ----------------------------------------------------------------------------
--  Pregunta de negocio:
--  "¿Qué proveedores tienen al menos UN producto que se haya vendido en una
--   sola orden con 50 o más unidades?"
--
--  Mostrá: company, state_province (sin repetir)
--  AUTOCHECK: 2 filas.
-- ============================================================================

-- ▼▼▼ ESCRIBÍ TU CONSULTA AQUÍ ▼▼▼

SELECT 	
	company, s.state_province
FROM suppliers s
WHERE EXISTS(
	SELECT 1
	FROM products p
	JOIN order_details o ON o.product_id = p.id
	WHERE o.quantity >= 50 AND p.supplier_ids = s.id);
	
-- ▲▲▲ FIN ▲▲▲


-- ============================================================================
--  PISTAS (solo si te trabás — no las mires de entrada)
-- ============================================================================
--  D1: Necesitás dos alias de la misma tabla y un AVG filtrado por categoría.
--  D2: La subconsulta devuelve customer_id DISTINCT de orders.
--  D3B: En el FROM armás una tabla con customer_id y COUNT(*), luego la unís.
--  D4: Comparás contra TODOS los de su proveedor, EXCLUYENDO su propia fila.
--  D5: El valor MÍNIMO de envío a NY te da la referencia de "cualquiera".
--  D6: El "puente" es comparar customer_id de la subconsulta con el de afuera.
--  D7: NOT EXISTS + subconsulta correlacionada contra order_details.
--  D8: Dos subconsultas escalares, cada una correlacionada por customer_id.
--  D9: Primero agrupás por producto en una derivada, después filtrás contra el AVG.
--  D10: Dentro del EXISTS unís products con order_details y filtrás >= 50.
-- ============================================================================
