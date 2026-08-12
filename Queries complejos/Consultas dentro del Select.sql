/* ============================================================================
   TEMA: Subconsultas en la cláusula SELECT (Campos Calculados)
   ============================================================================
   Objetivo: Ver la diferencia entre el valor de una fila individual (cada venta) 
   contra un valor global agregado (el promedio general).
============================================================================ */

-- ============================================================================
-- 1. EL ERROR COMÚN 
-- ============================================================================
/*
   ¿Por qué esto no sirve?
   Al usar AVG(venta) sin agrupar, el gestor entra en conflicto. Estás 
   mezclando columnas de detalle (ventas_id, venta que tienen muchas filas) 
   con una función de agregación (AVG que devuelve una sola fila).
*/
SELECT ventas_id, venta, AVG(venta)
FROM ventas;


-- ============================================================================
-- 2. LA FORMA CORRECTA DE HACERLO (Según el curso)
-- ============================================================================
/*
   Solución:
   Usar una "subconsulta escalar" (una consulta que devuelve un solo número) 
   dentro del SELECT. Al hacerlo así, SQL calcula el promedio general una vez 
   y lo repite como una columna extra en cada fila.
*/
SELECT 
    ventas_id,
    venta,
    (SELECT AVG(venta) FROM ventas) AS promedioventa,
    venta - (SELECT promedioventa)
FROM ventas;


-- ============================================================================
-- 3. NIVEL PRO: LA FORMA MODERNA (Window Functions)
-- ============================================================================
/*
   En el mundo laboral actual, repetir subconsultas se considera poco óptimo. 
   Para hacer exactamente lo mismo, pero con código más limpio y rápido, se 
   usa la cláusula OVER(). Esto le dice a SQL: "Saca el promedio de toda 
   la ventana de datos, pero mantén las filas individuales".
*/
/*
SELECT 
    ventas_id,
    venta,
    AVG(venta) OVER() AS promedioventa,
    venta - AVG(venta) OVER() AS diferencia_vs_promedio
FROM ventas;
*/

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Subconsulta Escalar: Una subconsulta en el SELECT SIEMPRE debe devolver 
     una sola columna y una sola fila (un valor único). Si devuelve más, 
     el script fallará.
   - Rendimiento: Si la tabla tiene millones de registros, usar Window 
     Functions (OVER) será mucho más eficiente que usar subconsultas en el SELECT.
============================================================================ */