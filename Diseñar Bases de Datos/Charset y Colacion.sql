/* ============================================================================
   TEMA: Charset y Colación
   ============================================================================
   Objetivo: Separar las dos piezas que suelen confundirse: el charset, que
   decide qué caracteres se pueden guardar, y la colación, que decide cómo se
   comparan. Elegirlas mal no molesta el primer día, pero se paga cuando la
   base ya tiene datos y otras herramientas la leen.
============================================================================ */

# EL Charset es el set de simbolos y codificaciones que vas a aceptar en la base de datos: Basicamente que alfabeto va a estar aceptando

/*
   Son dos cosas dentro de la misma palabra, y conviene separarlas:

   - El conjunto de símbolos es el repertorio: qué caracteres existen para la
     base (una 'á', una 'ñ', un emoji). Lo que no está en ese repertorio no se
     puede guardar tal cual.
   - La codificación es cuántos bytes ocupa cada símbolo al guardarlo. Un
     mismo texto pesa distinto según el charset, y de ahí salen los límites de
     tamaño de un VARCHAR y el ancho máximo de un índice.

   Por eso un charset mal elegido no solo rechaza caracteres: también cambia
   cuánto ocupa el dato en disco.
*/

# Por default para MySQL es UTF-8
 
/*
   El matiz que importa: en MySQL, 'UTF-8' es un nombre incompleto. El
   charset que cubre todo es utf8mb4 (hasta 4 bytes por carácter), y el
   histórico 'utf8' es en realidad utf8mb3: se queda en 3 bytes, así que no
   admite emoji ni varios caracteres CJK. En MySQL 8.0 el default del
   servidor ya es utf8mb4 (con su colación utf8mb4_0900_ai_ci); en 5.7 era
   latin1.

   La consecuencia práctica: la línea se lee bien, pero 'UTF-8' hay que
   traducirlo a un charset concreto al crear la base, y no siempre es el
   mismo.
*/

# Para cada charser hay una colacion, es el set de reglas para comparar caracteres en un charset

/*
   La relación es de uno a muchos: un charset tiene varias colaciones, y cada
   colación pertenece a un charset. Se eligen juntas, nunca por separado.

   La colación no cambia el dato guardado: cambia las comparaciones y los
   ordenamientos. Decide si 'Jose' y 'José' son el mismo valor, si 'A' y 'a'
   lo son, y cómo se ordena una lista.

   El sufijo del nombre se lee así:
   - ai / as: accent-insensitive o accent-sensitive.
   - ci / cs: case-insensitive o case-sensitive.
   - _bin: compara byte a byte, sensible a mayúsculas y a acentos.
   Por ejemplo, utf8mb4_0900_ai_ci no distingue 'a' de 'á'.

   Eso se paga en un UNIQUE: con una colación ai_ci, dos filas que a la vista
   son distintas ('Álvaro' y 'Alvaro') pueden chocar contra la misma clave.
*/

# SHOW CHARSET Muestra toda la lista de charsets disponibles

	SHOW CHARSET;
	
/*
   La salida trae, por cada charset, su descripción, su colación por defecto
   y el ancho máximo en bytes (Maxlen). Ese Maxlen es el número que explica la
   diferencia entre utf8 (3) y utf8mb4 (4).

   El nombre que aparece en la documentación de MySQL es SHOW CHARACTER SET;, y
   su compañera es SHOW COLLATION;: esa lista todas las colaciones e indica a
   qué charset pertenece cada una.
*/

# Es importante ver compatibilida ya que despues en cosas con pyhon u ptras herramientas puede causar conflicto 

/*
   Ese es el punto que más caro sale, y tiene dos frentes distintos:

   - La conexión: el cliente (Python, la terminal, Workbench) trae su propio
     charset. Si no coincide con el de la base, el motor puede rechazar o
     deformar caracteres al escribir, y no siempre avisa. El dato queda mal
     guardado y el error aparece recién al leerlo.
   - La comparación: aunque el dato esté bien guardado, una colación
     inesperada cambia el resultado de los WHERE, los JOIN y los UNIQUE. Es
     un bug que no se ve en pruebas con texto sin acentos y aparece con datos
     reales.

   Por eso la compatibilidad no se revisa solo al crear la base: se revisa en
   cada conexión que la va a usar.
*/

/* ============================================================================
   CHARSET Y COLACIÓN EN PRODUCCIÓN: ELEGIR ANTES DE QUE HAYA DATOS
   ----------------------------------------------------------------------------
   - Se eligen al crear la base, no después: utf8mb4 es la opción sensata hoy
     y latin1 solo se justifica para datos heredados que no se van a tocar.
   - Antes de migrar una base existente, mirar qué tiene. Eso está en el
     metadato: information_schema.SCHEMATA guarda el charset y la colación por
     defecto del esquema, e information_schema.COLUMNS los de cada columna.
   - 'utf8' en MySQL no es utf8mb4: los scripts viejos con DEFAULT
     CHARSET=utf8 quedaron limitados a 3 bytes y hay que revisarlos.
   - La colación de la columna y la de la conexión pueden no coincidir, y la
     comparación se resuelve con una mezcla de las dos. Si un WHERE no da lo
     esperado entre textos iguales, comparar antes las colaciones.
   - Los VARCHAR y los índices se miden en bytes, no en caracteres: elegir el
     charset también es elegir cuánto entra.

   ----------------------------------------------------------------------------
   NIVEL PRO: LA MIGRACIÓN A utf8mb4 (lo que el curso no cubre)
   ----------------------------------------------------------------------------
   Pasar una base existente a utf8mb4 es una conversión de datos, no un
   cambio de nombre: el motor reescribe la tabla y reconstruye sus índices.

   - Sentar la conexión primero, o la conversión misma puede deformar texto:
     SET NAMES utf8mb4;
   - Convertir tabla por tabla, y revisar el largo de las columnas de texto
     antes: al pasar de 3 a 4 bytes, un VARCHAR grande puede pasarse del
     límite de la fila.
     -- Estructura ilustrativa (ajusta el nombre de la tabla):
     -- ALTER TABLE <tabla> CONVERT TO CHARACTER SET utf8mb4
     --     COLLATE utf8mb4_0900_ai_ci;
   - Para una columna suelta existe MODIFY COLUMN con CHARACTER SET y COLLATE
     explícitos, que también declara el tipo.
   - Con datos en producción, la conversión se prueba primero sobre una
     copia: reescribe la tabla y no se deshace sola.
============================================================================ */
