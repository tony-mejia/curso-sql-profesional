/* ============================================================================
   TEMA: Índices de Texto y Prefijos (apellido(1), apellido(2))
   ============================================================================
   Objetivo: Medir qué tan selectiva es una columna de texto, y decidir con
   números cuántos caracteres conviene indexar en lugar de adivinar.
============================================================================ */

-- ============================================================================
-- 1. POR QUÉ EL TEXTO ES MÁS DIFÍCIL QUE LOS NÚMEROS
-- ============================================================================
# Los indices que tienen que ver especificamente con texto son mas dificiles de armas que los indices de numero

/*
   No es capricho, hay dos razones concretas:

   - El tamaño. Un INT ocupa 4 bytes fijos. Un VARCHAR puede ocupar 5 o 60,
     así que el índice crece y hay que decidir cuánto guardar. De ahí salen
     los prefijos que vas a probar más abajo.
   - La repetición. En un texto hay pocos valores distintos y muchas filas
     por valor ('Garcia' puede estar en 20.000 filas). Un índice así descarta
     poco: el motor lo usa, pero después igual tiene que revisar miles de
     filas una por una.
*/

-- ============================================================================
-- 2. MEDIR QUÉ TAN SELECTIVA ES LA COLUMNA
-- ============================================================================
SELECT * FROM empleados;

SHOW INDEX IN empleados;

# Vamos a armas un indice por apellido

/*
   Antes de crear nada, se mide. Y la medida que importa es: ¿cuántos valores
   DISTINTOS hay en la columna? Eso es la cardinalidad, y es lo que decide si
   un índice sirve o no.

   Ya la viste en 'Indexing/Mostrar y Eliminar Indices-01.sql': es la misma
   columna 'Cardinality' que muestra SHOW INDEX, solo que aquí la calculas tú.
*/
SELECT COUNT(DISTINCT Apellido) FROM empleados;

/*
   Cómo se lee: si ese número se acerca al total de filas de la tabla, la
   columna es muy selectiva y el índice vale mucho. Si es chico comparado con
   las filas, el índice ayuda poco.
*/

-- ============================================================================
-- 3. LA IDEA DEL PREFIJO
-- ============================================================================
# Podemos generar el indice no apartir de todo el apellido completo sino a partir de una catidad de caracteres
# Tenemos que pensar que tantos caracteres voy a tomar para hacer mi indice que mantenga el desempeño del indice pero al mismo tiempo no abarque mucho espacio en la memoria

/*
   Exacto, y esa es la pregunta central de este apunte. La sintaxis es
   'columna(N)': indexar solo los primeros N caracteres.

   Y la forma de responder "cuántos caracteres" es la consulta de abajo:
   medir la cardinalidad de los primeros 1, 2, 3... caracteres y compararla
   con la del apellido completo.
*/
SELECT COUNT(DISTINCT LEFT(Apellido,1)) FROM empleados;

/*
   Un matiz sobre "que no abarque mucho espacio en la memoria": el índice no
   vive en la memoria, vive en disco. Lo que sí pasa por RAM es su página
   cuando el motor la lee, y ahí se queda un rato en el buffer pool.

   Así que el criterio real no es "que no ocupe memoria", sino "que no ocupe
   disco de más" y, sobre todo, que el índice siga discriminando bien.
*/

-- ============================================================================
-- 4. PROBAR: ÍNDICE COMPLETO CONTRA PREFIJO
-- ============================================================================
CREATE INDEX idx_apellido ON empleados (apellido);

SHOW INDEX IN empleados;

EXPLAIN SELECT * FROM empleados WHERE apellido = 'agudelo';

/*
   Con el índice completo, el EXPLAIN debería mostrar 'idx_apellido' en la
   columna 'key'. Guarda ese plan, porque es tu punto de comparación.
*/

DROP INDEX idx_apellido ON empleados;

CREATE INDEX idx_apellido ON empleados (apellido(1));

DROP INDEX idx_apellido ON empleados;

CREATE INDEX idx_apellido ON empleados (apellido(2));

/*
   Dos cosas de este experimento:

   - La consulta del EXPLAIN sigue funcionando con el prefijo. Con
     'apellido(2)' el motor busca todo lo que empieza con 'ag' y después
     compara el valor completo contra la fila. Encontrar, encuentra bien;
     lo que cambia es cuánto trabajo hace antes de llegar.
   - Ojo con el nombre repetido: hiciste DROP antes de cada CREATE porque no
     puede haber dos índices con el mismo nombre en la misma tabla. El ciclo
     crear -> probar -> borrar -> crear otro queda bien claro así.
*/

-- ============================================================================
-- 5. NIVEL PRO: ELEGIR EL LARGO DEL PREFIJO CON NÚMEROS
-- ============================================================================
/*
   En vez de probar 1, 2 y 3 a ojo, se mide: se compara la cardinalidad del
   prefijo contra la del valor completo, para cada largo posible.

   Es la misma consulta que ya escribiste, con LEFT(Apellido, N), puesta en
   columnas para poder comparar de un vistazo.
*/
-- SELECT
--   COUNT(DISTINCT Apellido)          AS completo,
--   COUNT(DISTINCT LEFT(Apellido,1))  AS prefijo_1,
--   COUNT(DISTINCT LEFT(Apellido,2))  AS prefijo_2,
--   COUNT(DISTINCT LEFT(Apellido,3))  AS prefijo_3
-- FROM empleados;

/*
   Cómo se lee el resultado: buscas el largo más chico que conserva casi toda
   la cardinalidad del apellido completo. Si con 2 caracteres ya llegas cerca
   del total, 'apellido(2)' te da casi el mismo poder de búsqueda por una
   fracción del espacio.

   El criterio no es "el más corto que ahorre disco", es "el más corto que
   todavía discrimine".
*/

/* ============================================================================
   LO QUE UN PREFIJO NO PUEDE HACER
   ----------------------------------------------------------------------------
   - No sirve para ORDENAR. Si el índice guarda solo los primeros N
     caracteres, no alcanza para determinar el orden completo: un ORDER BY
     sobre esa columna va a mostrar 'Using filesort' en el EXPLAIN y el
     índice queda de adorno.
   - No puede cubrir la consulta. Un índice cubriente necesita el valor
     entero dentro del índice, y el prefijo no lo tiene.
   - En columnas BLOB o TEXT el prefijo no es opcional: es obligatorio, y
     hay un tope de bytes que depende del formato de fila y del charset.
   - Para LEER, el índice completo casi siempre es mejor. El prefijo existe
     para cuando la columna es tan larga que indexarla entera no es viable.
============================================================================ */
