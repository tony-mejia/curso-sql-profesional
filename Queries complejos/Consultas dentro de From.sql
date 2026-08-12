/* ============================================================================
   TEMA: Subconsultas en la cláusula FROM (Tablas Derivadas)
   ============================================================================
   Objetivo: Utilizar el resultado de una consulta completa como si fuera 
   una tabla temporal nueva, de la cual podemos hacer un nuevo SELECT.
============================================================================ */

-- Las subconsultas las puedes meter en el where, en el select y en el from

-- ============================================================================
-- 1. EJEMPLO DE SUBCONSULTA DENTRO DEL FROM
-- ============================================================================
/*
   Aquí tomamos toda la consulta del ejercicio anterior (que calculaba 
   la diferencia contra el promedio) y la "encerramos" en el FROM.
   
   Regla de Oro: Todo lo que pongas entre paréntesis en un FROM necesita 
   obligatoriamente un alias al final (en este caso: AS promedio). Si no 
   se lo pones, SQL marcará error.
*/
SELECT *
FROM (
	SELECT
		ventas_id,
		venta,
		(SELECT AVG(venta) from ventas) AS promedioventa,
		venta - (SELECT promedioventa)
	FROM ventas) AS promedio;


-- ============================================================================
-- 2. LA FINALIDAD DE HACER ESTO ES HACER OPERACIONES (FILTRAR)
-- ============================================================================
/*
   ¿Por qué hacemos esto? 
   Por el Orden de Ejecución de SQL. SQL lee primero el FROM, luego el WHERE 
   y hasta el final el SELECT. Si intentas usar el alias "delta" en un WHERE 
   normal, SQL te dirá "la columna delta no existe", porque aún no la ha creado.
   
   Solución: Al meterlo en el FROM, esa consulta se convierte en una "tabla". 
   Ahora la columna "delta" ya existe formalmente para la consulta externa, 
   y ya podemos usarla en el WHERE.
*/
SELECT *
FROM (
	SELECT
		ventas_id,
		venta,
		(SELECT AVG(venta) from ventas) AS promedioventa,
		venta - (SELECT promedioventa) AS delta
	FROM ventas) AS promedio
WHERE delta > 100;


-- ============================================================================
-- 3. NIVEL PRO: LA FORMA MODERNA CON "CTE" (Common Table Expressions)
-- ============================================================================
/*
   Meter subconsultas en el FROM puede hacer que el código se vuelva muy 
   difícil de leer si se anidan muchas veces (el temido "código espagueti").
   
   En el mundo real se utiliza la cláusula WITH para crear una CTE. 
   Esto hace exactamente lo mismo, pero se lee de arriba hacia abajo, 
   haciendo el código mucho más limpio y profesional.
*/
/*
WITH TablaPromedio AS (
    SELECT
        ventas_id,
        venta,
        AVG(venta) OVER() AS promedioventa,
        venta - AVG(venta) OVER() AS delta
    FROM ventas
)
SELECT *
FROM TablaPromedio
WHERE delta > 100;
*/

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Obligatorio: Las tablas derivadas (subconsultas en el FROM) siempre 
     deben tener un nombre o Alias (AS nombre_tabla).
   - Ámbito (Scope): Esa tabla derivada solo existe durante el milisegundo 
     en que se ejecuta la consulta. No se guarda permanentemente en la base 
     de datos.
============================================================================ */
