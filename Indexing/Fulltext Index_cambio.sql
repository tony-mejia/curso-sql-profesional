/* ============================================================================
   TEMA: Índices Full-Text (Buscar Dentro de los Textos)
   ============================================================================
   Objetivo: Entender en qué se diferencia un FULLTEXT de un índice normal,
   cómo se consulta con MATCH ... AGAINST, y las limitaciones que sorprenden
   la primera vez que "no encuentra nada".
============================================================================ */

-- ============================================================================
-- 1. QUÉ ES Y PARA QUÉ SIRVE
-- ============================================================================
# Tipo especial de indice que es para indizar texto enteros, full-text index

# Se podria guardar las descripciones de un producto o la entrada de un blog 

# ¿Cual es el proposito de este indice?
# No es mejorar la busqueda dentro de la tabla, es mejorar la busqueda dentro de los textos

/*
   Ese es exactamente el punto, y conviene decir con precisión qué lo hace
   distinto.

   Un índice normal (B-tree) compara VALORES o PREFIJOS: le pides 'pzz' y
   encuentra las filas donde la columna vale eso.

   Un FULLTEXT hace otra cosa: parte el texto en PALABRAS y arma un índice
   invertido (palabra -> filas que la contienen). Por eso sirve para buscar
   DENTRO del texto, y no para comparar la columna entera.

   La diferencia se ve en el rendimiento:
   - LIKE '%booleano%' no puede usar índice: obliga a leer fila por fila.
   - MATCH() AGAINST() sí puede: el motor va directo a la palabra.
*/

-- ============================================================================
-- 2. CREARLO
-- ============================================================================
SELECT * FROM blogger;

SHOW INDEX IN blogger;

# CREATE FULLTEXT INDEX: Utilizado para crear indices de columnas basadas en texto (CHAR, VARCHAR O TEXT)

CREATE FULLTEXT INDEX idx_titulo_contenido ON blogger (titulo, contenido);

/*
   Tres cosas del CREATE de arriba que conviene leer despacio:

   - FULLTEXT solo existe en InnoDB y MyISAM, y solo sobre columnas CHAR,
     VARCHAR o TEXT. Sobre un INT no se puede crear.
   - Al ser un índice sobre DOS columnas, el MATCH tiene que nombrar las dos,
     y en el mismo orden, para poder usarlo.
   - El nombre 'idx_titulo_contenido' deja claro qué cubre: titulo + contenido.
*/

-- ============================================================================
-- 3. CONSULTARLO
-- ============================================================================
SELECT * FROM blogger WHERE MATCH(titulo,contenido) AGAINST('booleano');

/*
   MATCH(columnas) y AGAINST('texto') van siempre juntos: son una sola unidad,
   no dos cláusulas sueltas. Si el MATCH no nombra exactamente las columnas
   del índice, el motor no lo usa.

   Y ojo con qué significa "encontrar" aquí: el motor busca la PALABRA, no el
   texto. 'booleano' NO va a encontrar una fila que diga 'booleanos'. Para
   eso está el comodín, en la sección siguiente.
*/

-- ============================================================================
-- 4. NIVEL PRO: BUSCAR CON OPERADORES (IN BOOLEAN MODE)
-- ============================================================================
/*
   El modo por defecto se llama lenguaje natural: le pasas palabras y MySQL
   las ordena por relevancia. Pero no te deja decir "esto sí, esto no".

   El modo booleano sí, y se activa agregando IN BOOLEAN MODE al final.
   Los operadores van al principio o al final de cada palabra:
   - palabra   -> opcional: suma si aparece
   - +palabra  -> DEBE estar
   - -palabra  -> NO debe estar
   - palabra*  -> comodín: coincide con palabras que empiezan así
   - "frase"   -> la frase completa, en ese orden

   Ejemplos (descomenta para probarlos sobre tu tabla):
*/
-- SELECT * FROM blogger
--   WHERE MATCH(titulo,contenido) AGAINST('+booleano -java' IN BOOLEAN MODE);

-- SELECT * FROM blogger
--   WHERE MATCH(titulo,contenido) AGAINST('boolean*' IN BOOLEAN MODE);

/* ============================================================================
   LO QUE SORPRENDE LA PRIMERA VEZ (y explica el "no encuentra nada")
   ----------------------------------------------------------------------------
   - Palabras demasiado cortas: InnoDB no indexa palabras de menos de 3
     caracteres ni de más de 84. Buscar 'de' no devuelve nada, y no es un
     error tuyo. Se ajusta con innodb_ft_min_token_size y
     innodb_ft_max_token_size.
   - Palabras vacías (stopwords): hay una lista de palabras que se ignoran.
     Se consulta en INFORMATION_SCHEMA.INNODB_FT_DEFAULT_STOPWORD.
   - Borrados que quedan pesando: en InnoDB, cuando borras filas, sus palabras
     no salen del índice al instante; se guardan aparte y se filtran de los
     resultados. Recién con OPTIMIZE TABLE se eliminan de verdad y el índice
     se compacta.
   - Y no sirve para ordenar ni para comparar el texto completo. Para eso
     sigue haciendo falta un índice normal.
============================================================================ */
