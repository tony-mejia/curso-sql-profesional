/* ============================================================================
   TEMA: Índices Compuestos (Varias Columnas en un Solo Índice)
   ============================================================================
   Objetivo: Decidir cuándo un índice de una sola columna no alcanza, entender
   cómo el orden de las columnas decide qué consultas sirve, y comprobarlo con
   EXPLAIN antes de crearlo.
============================================================================ */

-- ============================================================================
-- 1. QUÉ ES UN ÍNDICE COMPUESTO
-- ============================================================================
# El indice compuesto es cuando utilizamos dos o mas columnas para generar el indice 

SHOW INDEX IN ventas_idx;

/*
   Un compuesto se ordena como un listín telefónico: primero por la primera
   columna y, dentro de cada valor de esa, por la segunda.

   De ahí sale la regla que gobierna todo el tema (Leftmost Prefix Rule), que
   ya viste en 'Modelado de datos/Claves Primarias.sql'. El manual de MySQL la
   enuncia así: "cualquier prefijo más a la izquierda del índice puede ser
   usado por el optimizador para buscar filas".

   Entonces (clave_producto, venta) sí queda indexado para buscar por:
   - clave_producto
   - clave_producto + venta
   Y NO para buscar por 'venta' solo, porque va en segundo lugar.
*/

-- ============================================================================
-- 2. LA FASE DE PRUEBA (Medir antes de crear)
-- ============================================================================
# Vamos a evaluar, para entender cual es nuestra mejor opcion

/*
   Ese es exactamente el orden correcto: primero mides, después creas.
   Lo que hay que mirar en la salida de EXPLAIN:
   - key:      qué índice eligió el optimizador. NULL = no usó ninguno.
   - key_len:  cuántas partes del índice compuesto usó DE VERDAD.
               Ahí está el detalle fino: si el índice tiene 2 columnas y el
               key_len solo refleja una, el motor está usando media herramienta.
   - rows:     cuántas filas estima que tendrá que revisar (es una estimación).
   - type:     cómo va a buscar. 'ALL' = escaneo completo de la tabla.
*/
EXPLAIN SELECT venta_empleado
FROM ventas_idx
WHERE clave_producto = 'pzz' AND venta > 200;

-- ============================================================================
-- 3. CREAR EL ÍNDICE COMPUESTO
-- ============================================================================
# Puede ser mas optimo, tengo 2 columnas y si es una consulta que se va a ejecutar mucho, podemos hacer el indece compuesto

CREATE INDEX idx_claveproducto_venta ON ventas_idx(clave_producto,venta);

/*
   Y aquí el detalle que casi siempre se escapa:

   Con este índice, el 'idx_producto' que creaste en 'Indexing/Crear INDEX-02.sql'
   se queda sin trabajo propio. Cualquier consulta que use idx_producto (que es
   solo clave_producto) puede usar el compuesto por la regla del prefijo, porque
   clave_producto va primero.

   El simple solo aporta que ocupa menos espacio. En la práctica, cuando un
   compuesto arranca con la misma columna que un simple, el simple se termina
   borrando. Y ya sabes cómo: 'Indexing/Mostrar y Eliminar Indices-01.sql'.
*/

/*
   Ojo con el orden, porque no se elige por gusto: se elige por las consultas
   que vas a correr. Si además necesitas filtrar por 'venta' sin saber el
   producto, este índice NO te sirve. Necesitarías uno que empiece por 'venta',
   y eso es un índice distinto, no el mismo al revés.
*/

-- ============================================================================
-- 4. NIVEL PRO: QUE LA CONSULTA NO TOQUE LA TABLA (Índice cubriente)
-- ============================================================================
/*
   Volvamos a la consulta del paso 2: filtra por (clave_producto, venta), pero
   DEVUELVE 'venta_empleado', que no está en el índice.

   Entonces el motor usa el índice para encontrar las filas y después va a la
   tabla a buscar 'venta_empleado' en cada una. Ese viaje extra es el lookup.

   Si agregas esa columna al final del índice, el índice ya contiene todo lo que
   la consulta necesita y la tabla no se toca. Eso es un índice cubriente. El
   manual de MySQL lo confirma: si el índice es cubriente y puede satisfacer
   todos los datos que la consulta requiere, solo se recorre el árbol del
   índice. Y EXPLAIN lo delata en la columna Extra con 'Using index'.
*/
-- CREATE INDEX idx_claveproducto_venta_empleado
--   ON ventas_idx(clave_producto, venta, venta_empleado);

/* ============================================================================
   LO QUE CUESTA UN ÍNDICE COMPUESTO (y no se ve en SHOW INDEX)
   ----------------------------------------------------------------------------
   - Cada columna extra engorda el índice: más disco y más trabajo en cada
     INSERT, UPDATE y DELETE.
   - (a, b) y (b, a) son dos índices distintos, que sirven a consultas
     distintas. No es el mismo índice al revés.
   - En InnoDB, todo índice secundario guarda además la clave primaria. Por eso
     una consulta que solo pida la PK ya viene cubierta sin que hagas nada.
   - Antes de crear uno nuevo, revisa si el que ya tienes sirve por prefijo.
     Un índice de más cuesta tanto como uno de menos.
============================================================================ */
