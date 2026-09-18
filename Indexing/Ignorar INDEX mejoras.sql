/* ============================================================================
   TEMA: Cuándo el OR Arruina un Índice (y la Reescritura con UNION)
   ============================================================================
   Objetivo: Ver con EXPLAIN cómo una condición escrita con OR puede dejar al
   motor sin índice, entender por qué pasa, y reescribir la misma consulta
   para que sí use los índices que tienes.
============================================================================ */

-- ============================================================================
-- 1. LA CONSULTA ORIGINAL (La fase de prueba)
-- ============================================================================
SHOW INDEX IN ventas_idx;

/*
   Antes de mirar el EXPLAIN, mira qué índices existen (el SHOW INDEX de
   arriba). La respuesta al problema está ahí.

   Esta consulta le pide al motor dos cosas distintas a la vez:
   - filas donde clave_producto = 'pzz'
   - filas donde venta > 1000

   Y aquí viene el detalle: el índice compuesto 'idx_claveproducto_venta'
   que creaste en 'Indexing/INDEX Compuesto 1.sql' empieza por
   clave_producto. Por la regla del prefijo, ese índice SIRVE para la
   primera rama, pero NO puede resolver 'venta > 1000' por su cuenta,
   porque 'venta' va en segundo lugar.

   Resultado: una de las dos ramas se queda sin índice.
*/
EXPLAIN SELECT ventas_idx_id
FROM ventas_idx
WHERE clave_producto = 'pzz' OR venta > 1000;

-- ============================================================================
-- 2. QUÉ ESTÁ PASANDO POR DENTRO
-- ============================================================================
# Al usar OR el indice busco en todas las filas

/*
   Casi siempre es así, y el EXPLAIN lo confirma. Lo que hay que mirar es la
   columna 'type':
   - type = ALL: escaneo completo de la tabla. El índice quedó sin usar.
*/

/*
   Pero conviene conocer un matiz, porque no siempre termina en escaneo
   completo: MySQL tiene una optimización llamada Index Merge que SÍ puede
   usar dos índices distintos para resolver un OR.

   Cuando eso ocurre, el EXPLAIN lo muestra distinto:
   - type = index_merge
   - key = una LISTA de los índices usados, no uno solo

   Así que la regla no es "OR siempre es malo", sino que OR es frágil: según
   el caso el motor puede resolverlo con dos índices o rendirse y escanear
   toda la tabla. Y eso no se adivina, se lee en el EXPLAIN.
*/

-- ============================================================================
-- 3. LA REESCRITURA CON UNION
-- ============================================================================
# Se recomienda mejorar la consulta

# En este caso usando UNION

/*
   Aquí partes la consulta en dos, y cada mitad va por su lado. Después
   UNION junta los resultados.
*/
EXPLAIN SELECT ventas_idx_id
FROM ventas_idx
WHERE clave_producto = 'pzz'
UNION
SELECT ventas_idx_id
FROM ventas_idx
WHERE venta > 1000;

/*
   Ojo con una diferencia que importa:

   - UNION elimina los repetidos (es lo que tienes aquí), y eso obliga al
     motor a un paso extra de deduplicación.
   - UNION ALL no los elimina, así que es más barato.

   ¿Cuál te conviene? Depende de si una fila puede caer en las dos mitades.
   En este caso SÍ puede: una venta de 'pzz' que además sea mayor a 1000
   cumple las dos condiciones. Por eso aquí UNION es la elección correcta,
   y cambiar a UNION ALL te duplicaría esa fila.
*/

-- ============================================================================
-- 4. LA CONCLUSIÓN
-- ============================================================================
# Podemos ver como la forma en como escribimos nuestras consultas puede afectar el desempeño y como el uso de los indices puede mejorar el desempeño

/* ============================================================================
   OR vs UNION: CÓMO SE COMPRUEBA CUÁL CONVIENE
   ----------------------------------------------------------------------------
   - Tu conclusión es la lección real: el mismo resultado se escribe de
     varias formas, y la forma decide si el índice se usa o no.
   - Cómo comprobarlo sin adivinar: compara la columna 'type' de los dos
     EXPLAIN. ALL (escaneo completo) es la señal de alarma; index_merge,
     range o ref significan que el motor sí usó un índice.
   - El costo escondido del UNION: dos recorridos más la deduplicación. En
     tablas enormes suele ganarle a un escaneo completo, pero no es gratis.
   - Y el orden importa: 'OR' es frágil porque depende de que el motor
     encuentre la forma de combinar índices. Partir la consulta en dos le
     quita esa decisión de las manos.
============================================================================ */
