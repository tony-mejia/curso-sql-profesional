/* ============================================================================
   TEMA: Operadores EXISTS y NOT EXISTS vs IN
   ============================================================================
   ¿Qué hace EXISTS?
   Se utiliza para comprobar si una subconsulta devuelve AL MENOS UNA fila.
   No le importa qué datos devuelve la subconsulta, solo le importa si 
   devuelve algo (VERDADERO) o no devuelve nada (FALSO).
============================================================================ */

-- ============================================================================
-- PRÁCTICA: Determinar qué empleado ha vendido y cuál no.
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. USANDO 'IN' Y SUBCONSULTA (El enfoque de "Lista")
-- ----------------------------------------------------------------------------
/*
   ¿Cómo funciona?
   Primero, SQL ejecuta la subconsulta de adentro y crea una lista en memoria
   (ej. 1, 3, 4, 7). Luego, revisa cada empleado para ver si su ID está 
   dentro de esa lista.
   Nota: Usar DISTINCT aquí es una buena práctica para que la lista no tenga 
   repetidos y la búsqueda sea más limpia.
*/
SELECT *
FROM empleados 
WHERE ID_empleado IN (
    SELECT DISTINCT venta_empleado
    FROM ventas
);
	

-- ----------------------------------------------------------------------------
-- 2. USANDO 'EXISTS' (El enfoque Booleano)
-- ----------------------------------------------------------------------------
/*
   ¿Cómo funciona?
   Usa una SUBCONSULTA CORRELACIONADA. Por cada empleado en la tabla principal,
   SQL "se asoma" a la tabla de ventas. 
   
   La gran ventaja de EXISTS: "Evaluación de cortocircuito". 
   En el momento en que SQL encuentra la PRIMERA venta de ese empleado, se 
   detiene y devuelve VERDADERO (no sigue buscando más ventas de él). 
   Esto lo hace MUY rápido.
*/
SELECT *
FROM empleados e 
WHERE EXISTS (
    -- Nota: En EXISTS no importa qué columna pongas en el SELECT.
    -- Podría ser SELECT 1 o SELECT * y funcionaría igual de rápido.
    SELECT venta_empleado
    FROM ventas
    WHERE venta_empleado = e.ID_empleado
);


-- ----------------------------------------------------------------------------
-- 3. USANDO 'NOT EXISTS' (Para buscar a los que NO han vendido)
-- ----------------------------------------------------------------------------
/*
   Hace exactamente lo contrario: devuelve VERDADERO si la subconsulta 
   NO encuentra ninguna fila que coincida.
   En términos de negocio: "Tráeme a los empleados que tienen 0 ventas".
*/
SELECT *
FROM empleados e 
WHERE NOT EXISTS (
    SELECT venta_empleado
    FROM ventas
    WHERE venta_empleado = e.ID_empleado
);


/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO (Pregunta de entrevista de SQL):
   ----------------------------------------------------------------------------
   - Rendimiento (IN vs EXISTS): 
     * Usa `IN` cuando la subconsulta devuelva pocos registros (una lista pequeña).
     * Usa `EXISTS` cuando las tablas sean gigantes (millones de registros), 
       ya que al encontrar la primera coincidencia, deja de buscar y ahorra 
       recursos.
   - El peligro de los NULLs:
     * Si la subconsulta de un `NOT IN` devuelve un valor NULL en su lista, 
       la consulta principal dejará de mostrar resultados (es un error común).
     * `NOT EXISTS` es inmune a los NULLs. Siempre es más seguro usar 
       `NOT EXISTS` que `NOT IN` en bases de datos reales.
============================================================================ */