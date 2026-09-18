

/* ============================================================================
   TEMA: Crear Índices y Leer el EXPLAIN (Antes y Después)
   ============================================================================
   Objetivo: Medir una consulta antes de crear el índice, ver con EXPLAIN
   cómo cambia el plan, y saber cuándo un índice NO vale la pena.
============================================================================ */

SELECT * FROM ventas_idx;

-- ============================================================================
-- 1. LA FASE DE PRUEBA (Medir antes de crear)
-- ============================================================================
# EXPLAIN SELECT: Muestra informacion sobre la ejecucion de la consulta 

/*
   Lo que devuelve EXPLAIN no es el resultado de la consulta, es el PLAN:
   cómo piensa el motor resolverla. Las columnas que importan:
   - possible_keys: qué índices PODÍA usar.
   - key:           cuál usó de verdad. NULL = ninguno.
   - rows:          cuántas filas estima revisar (es estimación, no exacto).
   - type:          la forma de buscar. 'ALL' = escaneo completo de la tabla.
*/
EXPLAIN SELECT venta_empleado FROM ventas_idx WHERE clave_producto = "pzz";

/*
   Nota sobre las comillas: con el sql_mode por defecto MySQL acepta las
   comillas dobles como texto, así que esto corre. Pero si activas
   ANSI_QUOTES, las comillas dobles pasan a significar nombre de columna y la
   consulta se rompe. La forma portable es con comilla simple: 'pzz'.
*/

-- ============================================================================
-- 2. CREAR EL ÍNDICE
-- ============================================================================
#usar index no es para todos los casos, solo cuando realmente la base de datos es grande 

# CREATE INDEX: Utilizado para crear indices en las tablas

CREATE INDEX idx_producto ON ventas_idx (clave_producto);

-- ============================================================================
-- 3. CUÁNDO VALE LA PENA (Y QUÉ PASA POR DENTRO)
-- ============================================================================
# Si vas a hacer una sola consulta igual no es necesario crear indice, pero si vas a estar constantemente hacer la misma consulta, claro que si crea el indice.

# Esta generando como tablas "fantasma" en la memoria de corto plazo, la ram.

/*
   Dos matices sobre esa segunda nota, porque es fácil quedarse con la idea
   equivocada:

   * El índice no vive en la RAM: vive en DISCO, dentro del tablespace. Lo que
     sí pasa por memoria es su página cuando el motor la lee, y ahí se queda
     un rato en el buffer pool (la caché de InnoDB). Por eso la primera
     consulta es lenta y las siguientes vuelan.

   * Tampoco son "tablas fantasma": el índice es una estructura real y
     persistente, con su propio espacio reservado en disco. No es temporal,
     no se borra al cerrar la conexión y se actualiza en cada escritura.
*/

-- ============================================================================
-- 4. COMPARAR: LA MISMA TABLA, OTRA COLUMNA SIN ÍNDICE
-- ============================================================================
# Toda la tabla esta indicizada 

/*
   Cuidado con esa conclusión: un índice sobre 'clave_producto' NO indiza
   "toda la tabla". Indiza UNA columna. Las demás siguen sin índice.

   La prueba está en el EXPLAIN de abajo, que filtra por 'ID_local'. Si no
   hay ningún índice que empiece por esa columna, vas a ver type = ALL: el
   motor recorre la tabla entera.

   Y ahí está la comparación que vale: los dos EXPLAIN del archivo, uno al
   lado del otro. Misma tabla, dos columnas, dos planes distintos.
*/
EXPLAIN SELECT venta_empleado FROM ventas_idx WHERE ID_local = 2;

/* ============================================================================
   UN ÍNDICE NO ES GRATIS
   ----------------------------------------------------------------------------
   - Acelera las LECTURAS que filtran u ordenan por su columna, y frena las
     ESCRITURAS: cada INSERT, UPDATE y DELETE tiene que mantenerlo al día.
   - Ocupa disco, aparte del espacio de la tabla.
   - No sirve para cualquier consulta, solo para las que usan su columna, y
     solo si la condición es lo bastante selectiva.
   - Regla práctica: índice para consultas que se repiten mucho, no para una
     consulta suelta. Es exactamente lo que anotaste.
============================================================================ */
