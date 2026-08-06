/* ============================================================================
   TEMA: Funciones de Agregación (GROUP BY) y Subconsultas Correlacionadas
   ============================================================================ */

-- ============================================================================
-- 1. FORMA TARDADA (Manual y poco escalable)
-- ============================================================================
/* 
   Aquí calculamos el promedio (AVG) de ventas por cada local individualmente.
   Problema: Si tuviéramos 500 locales, tendríamos que escribir 500 consultas.
   No es dinámico ni eficiente.
*/
SELECT AVG(venta) FROM ventas WHERE ID_local = 1;
SELECT AVG(venta) FROM ventas WHERE ID_local = 2;
SELECT AVG(venta) FROM ventas WHERE ID_local = 3;
SELECT AVG(venta) FROM ventas WHERE ID_local = 4;


-- ============================================================================
-- 2. FORMA MÁS RÁPIDA (Usando GROUP BY)
-- ============================================================================
/*
   GROUP BY agrupa las filas que tienen los mismos valores en columnas específicas.
   Aquí le decimos: "Haz grupos por cada 'id_local' distinto, y a cada grupo 
   calcúlale su promedio de venta".
   Resultado: Una lista limpia con cada local y su respectivo promedio.
*/
SELECT id_local, AVG(venta)
FROM ventas
GROUP BY ID_local;


-- ============================================================================
-- 3. APLICACIÓN DE CONSULTAS CORRELACIONADAS
-- ============================================================================
/*
   ¿Qué es una Subconsulta Correlacionada?
   A diferencia de una subconsulta normal (que se ejecuta una sola vez), la 
   correlacionada DEPENDE de la consulta principal. Se evalúa una vez por CADA 
   FILA que procesa la consulta principal.

   ¿Qué hace esta consulta a nivel de negocio?
   Devuelve todas las ventas que fueron MAYORES al promedio de ventas de SU 
   PROPIO LOCAL. No compite contra el promedio general, sino contra el suyo.
*/
SELECT *
FROM ventas v -- 'v' es el alias de la consulta principal (externa)
WHERE venta > (
    -- Esta subconsulta se ejecuta para cada fila de la consulta principal
    SELECT AVG(venta)
    FROM ventas
    -- Aquí está la CORRELACIÓN (El puente):
    -- Comparamos el ID_local de la subconsulta con el ID_local de la fila 
    -- actual que se está evaluando en la tabla externa ('v').
    WHERE ID_local = v.ID_local);

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Alias Obligatorio: En consultas correlacionadas, es vital usar alias 
     (como la 'v') para evitar ambigüedades y decirle a SQL exactamente qué 
     tabla debe leer.
   - Rendimiento: Las subconsultas correlacionadas pueden ser lentas en tablas 
     con millones de registros porque la subconsulta se recalcula fila por fila.
   - Evolución: Hoy en día, este mismo resultado se puede lograr de forma más 
     eficiente usando "Funciones de Ventana" (Window Functions) con OVER().
============================================================================ */