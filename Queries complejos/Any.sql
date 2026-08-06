/* ============================================================================
   TEMA: Operador ANY en SQL
   ============================================================================
   ¿Qué hace ANY?
   Compara un valor escalar (como el total de una venta) con un conjunto de 
   valores devueltos por una subconsulta. 
   
   La condición se cumple (es TRUE) si la operación es verdadera para 
   AL MENOS UNO de los valores de esa subconsulta.
   
   Sinónimos: SOME hace exactamente lo mismo que ANY.
============================================================================ */

-- 1. CONSULTA BASE (La Subconsulta)
-- Esta consulta nos sirve para ver qué valores nos va a devolver el local 2.
-- Imagina que devuelve las ventas: $100, $250 y $500.
SELECT venta
FROM ventas 
WHERE ID_local = 2;

-- 2. APLICACIÓN DE ANY
/* 
   Aquí estamos buscando TODAS las ventas de la tabla general que sean mayores
   (>) a CUALQUIERA (ANY) de las ventas del local 2.
   
   Siguiendo el ejemplo anterior ($100, $250, $500):
   Si una venta es de $150, aparecerá en el resultado porque es mayor a $100.
   En resumen: "> ANY" equivale matemáticamente a decir "mayor que el valor MÍNIMO 
   devuelto por la subconsulta".
*/
SELECT *
FROM ventas
WHERE venta > ANY (
    SELECT venta
    FROM ventas
    WHERE ID_local = 2
);

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - `= ANY` es exactamente lo mismo que usar el operador `IN`.
   - `< ANY` significa "menor que el valor MÁXIMO devuelto por la subconsulta".
   - Si la subconsulta no devuelve ningún registro, la consulta principal 
     tampoco devolverá nada (el resultado de la comparación es FALSE).
============================================================================ */