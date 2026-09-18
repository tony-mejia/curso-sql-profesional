/* ============================================================================
   TEMA: Mostrar y Eliminar Índices (SHOW INDEX y DROP INDEX)
   ============================================================================
   Objetivo: Leer qué índices tiene una tabla, entender las dos columnas de
   su salida que más se malinterpretan, y deshacerse de un índice que ya no
   sirve sin tumbar el rendimiento.
============================================================================ */

-- ============================================================================
-- 1. VER LOS ÍNDICES DE UNA TABLA
-- ============================================================================
# SHOW INDEX: Comando que devuelve una de las listas de los indices pertenecientes a cierta tabla

SHOW INDEX in ventas_idx;

/*
   Cómo leer la salida, columna por columna:
   - Key_name: el nombre del índice. La clave primaria se llama siempre 'PRIMARY'.
   - Column_name: la columna indexada.
   - Seq_in_index: su posición dentro del índice (1, 2, 3... en los compuestos).

   Ojo con una trampa de nombres: la columna 'Collation' de aquí NO es la
   colación del charset que viste en 'Diseñar Bases de Datos/Charset y Colacion.sql'.
   Es la misma palabra usada para dos cosas distintas.
*/

-- ============================================================================
-- 2. LAS DOS COLUMNAS QUE MÁS SE MALINTERPRETAN
-- ============================================================================
# Las collation nos indica si esta organizado de manera ascendente o descendente
# Cardinality nos indica cuantos valores diferentes existen en un indice

/*
   Las dos van bien encaminadas, cada una con un matiz:

   * 'Collation' aquí responde a "¿cómo está ordenada la columna DENTRO del
     índice?": A (ascendente), D (descendente), o NULL (sin ordenar).

   * 'Cardinality' es una ESTIMACIÓN, no un conteo exacto. El motor la calcula
     con estadísticas guardadas como enteros, así que ni en tablas chicas da
     el número exacto. Se refresca con ANALYZE TABLE.

   * El matiz que sí cambia decisiones: a MÁS cardinality, más útil es el
     índice. Si tiene muchos valores distintos, el motor descarta muchísimas
     filas de un solo salto. Si es baja (un campo 'activo' con 0 y 1), el
     índice casi no ayuda y solo cuesta espacio y escrituras.
*/

-- ============================================================================
-- 3. DESHACERSE DE UN ÍNDICE
-- ============================================================================
# Que deberiamos hacer si queremos deshacernos de algun indice

/*
   El nombre tiene que existir tal cual. En 'Indexing/Crear INDEX-02.sql' el
   índice que creaste fue 'idx_producto', no 'venta_index'. Si el nombre no
   existe, MySQL corta con:
   "Can't DROP 'venta_index'; check that column/key exists"
*/
DROP INDEX venta_index ON ventas_idx;

-- ============================================================================
-- 4. NIVEL PRO: PROBAR ANTES DE BORRAR (Índices invisibles, MySQL 8.0+)
-- ============================================================================
/*
   Borrar un índice en producción da miedo, y con razón: si lo borras y alguna
   consulta lo necesitaba, el rendimiento se cae, y volver atrás implica
   reconstruirlo entero.

   Desde MySQL 8.0 existe una salida intermedia: apagarlo sin borrarlo. El
   índice sigue existiendo y se sigue actualizando en cada escritura, pero el
   optimizador deja de considerarlo. Si todo sigue rápido, lo borras con
   confianza; si algo se cae, lo vuelves a encender.

   No aplica a la PRIMARY KEY, solo a índices secundarios.
   Descomenta para probarlo sobre el índice que sí existe en tu tabla:
*/
-- ALTER TABLE ventas_idx ALTER INDEX idx_producto INVISIBLE;
-- ALTER TABLE ventas_idx ALTER INDEX idx_producto VISIBLE;

/* ============================================================================
   LO QUE NO SE VE EN SHOW INDEX (y sí importa)
   ----------------------------------------------------------------------------
   - Un índice no es gratis: cada INSERT, UPDATE y DELETE obliga al motor a
     mantenerlo al día. Índices de más = escrituras más lentas.
   - 'SHOW INDEX' lee de information_schema.STATISTICS. Si la tabla es enorme y
     solo quieres revisar una columna, filtrar ahí es más cómodo.
   - 'DROP INDEX' exige el privilegio ALTER sobre la tabla.
============================================================================ */
