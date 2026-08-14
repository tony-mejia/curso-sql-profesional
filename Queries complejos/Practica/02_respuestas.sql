-- ============================================================================
--  ⛔ RESPETÁ EL PROCESO ⛔
--  Archivo: 02_respuestas.sql
--
--  Este archivo contiene las RESPUESTAS de los 10 desafíos.
--  NO lo abras hasta haber intentado cada desafío por tu cuenta.
--  La práctica sirve para interiorizar los conceptos; espiar la respuesta
--  te roba el aprendizaje. Si te trabás, usá las PISTAS de 01_desafios.sql
--  y volvé a intentar. Después compará TU solución con estas (no hace falta
--  que sea idéntica: lo que importa es que devuelva lo mismo).
-- ============================================================================

USE practica_queries;

-- ----------------------------------------------------------------------------
-- DESAFÍO 1 — Subconsulta correlacionada (producto > promedio de su categoría)
-- ----------------------------------------------------------------------------
SELECT p1.product_name, p1.category, p1.list_price
FROM products p1
WHERE p1.list_price >
      (SELECT AVG(p2.list_price)
       FROM products p2
       WHERE p2.category = p1.category);


-- ----------------------------------------------------------------------------
-- DESAFÍO 2 — IN (clientes con al menos una orden)
-- ----------------------------------------------------------------------------
SELECT c.company
FROM customers c
WHERE c.id IN (SELECT o.customer_id FROM orders o);


-- ----------------------------------------------------------------------------
-- DESAFÍO 3 — Total de órdenes por cliente (JOIN vs subconsulta en FROM)
-- ----------------------------------------------------------------------------
-- 3A) JOIN
SELECT c.company, COUNT(o.id) AS total_ordenes
FROM customers c
JOIN orders o ON o.customer_id = c.id
GROUP BY c.company;

-- 3B) Subconsulta en FROM (tabla derivada)
SELECT c.company, t.total_ordenes
FROM customers c
JOIN (
    SELECT customer_id, COUNT(*) AS total_ordenes
    FROM orders
    GROUP BY customer_id
) AS t ON t.customer_id = c.id;


-- ----------------------------------------------------------------------------
-- DESAFÍO 4 — ALL (producto más caro que TODOS los de su mismo proveedor)
-- ----------------------------------------------------------------------------
SELECT p.product_name, p.list_price, p.supplier_ids
FROM products p
WHERE p.list_price > ALL (
    SELECT p2.list_price
    FROM products p2
    WHERE p2.supplier_ids = p.supplier_ids
      AND p2.id <> p.id
);


-- ----------------------------------------------------------------------------
-- DESAFÍO 5 — ANY (shipping_fee > cualquiera de los envíos a NY)
-- ----------------------------------------------------------------------------
SELECT id, ship_city, ship_state_province, shipping_fee
FROM orders
WHERE shipping_fee IS NOT NULL
  AND shipping_fee > ANY (
    SELECT o2.shipping_fee
    FROM orders o2
    WHERE o2.ship_state_province = 'NY'
      AND o2.shipping_fee IS NOT NULL
);


-- ----------------------------------------------------------------------------
-- DESAFÍO 6 — Subconsulta correlacionada (envío > promedio de su cliente)
-- ----------------------------------------------------------------------------
SELECT o.*
FROM orders o
WHERE o.shipping_fee >
      (SELECT AVG(o2.shipping_fee)
       FROM orders o2
       WHERE o2.customer_id = o.customer_id);


-- ----------------------------------------------------------------------------
-- DESAFÍO 7 — NOT EXISTS (productos nunca vendidos)
-- ----------------------------------------------------------------------------
SELECT p.id, p.product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_details od
    WHERE od.product_id = p.id
);


-- ----------------------------------------------------------------------------
-- DESAFÍO 8 — Subconsultas escalares en SELECT (count + sum por cliente)
-- ----------------------------------------------------------------------------
SELECT c.company,
       (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.id) AS total_ordenes,
       (SELECT SUM(o.shipping_fee) FROM orders o WHERE o.customer_id = c.id) AS total_envio
FROM customers c;


-- ----------------------------------------------------------------------------
-- DESAFÍO 9 — Subconsulta en FROM + promedio global (unidades por producto)
-- ----------------------------------------------------------------------------
SELECT p.product_name, v.total_unidades
FROM (
    SELECT product_id, SUM(quantity) AS total_unidades
    FROM order_details
    GROUP BY product_id
) AS v
JOIN products p ON p.id = v.product_id
WHERE v.total_unidades > (
    SELECT AVG(t.total_unidades)
    FROM (
        SELECT SUM(quantity) AS total_unidades
        FROM order_details
        GROUP BY product_id
    ) AS t
);


-- ----------------------------------------------------------------------------
-- DESAFÍO 10 — EXISTS + correlación (proveedores con producto vendido >= 50u)
-- ----------------------------------------------------------------------------
SELECT DISTINCT s.company, s.state_province
FROM suppliers s
WHERE EXISTS (
    SELECT 1
    FROM products p
    JOIN order_details od ON od.product_id = p.id
    WHERE p.supplier_ids = s.id
      AND od.quantity >= 50
);
