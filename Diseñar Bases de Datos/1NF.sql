/* ============================================================================
   TEMA: Primera Forma Normal (1FN)
   ============================================================================
   Objetivo: Entender las 4 reglas de 1FN sin malinterpretar la del dominio,
   y ver dónde se ubica cada forma normal en la escalera de la normalización.
============================================================================ */

/*
Normalizacion: Serie de reglas que se aplican a las tablas con el objetivo de asegurar eficiencia,
facilitar gestion y evitar redundancias
**/

/*
   Los tres objetivos que menciona esa definición suenan parecidos, pero el
   tercero es el que manda: evitar redundancias.

   Redundancia no es solo guardar de más: es guardar el mismo hecho en dos
   lugares distintos. Cuando eso pasa, los dos lugares pueden separarse: una
   fila se actualiza y la otra queda con el valor viejo. Ahí la base empieza a
   mentir sin que nadie toque nada, y ninguna consulta puede decir cuál de los
   dos valores es el correcto.
*/

/*
Reglas de Normalizacion:
1.1FN: Primera forma normal 
2.2FN: Segunda forma normal
3.3FN: Tercera forma normal
4.4FN: Cuarta forma normal
5.BCNF: Boyce-Codd normal form
6.5FN: Quinta forma normal
**/

/*
   Esa lista no son seis formas independientes: es una escalera. Cada forma
   incluye a las anteriores (2FN exige 1FN, 3FN exige 2FN, y así), de modo que
   decir 'no está en 3FN' implica que tampoco está en 2FN ni en 1FN.

   Tampoco todas pesan lo mismo en la práctica:

   - 1FN, 2FN y 3FN son las que se aplican todos los días, y son las tres que
     cubre el curso.
   - BCNF es más estricta que 3FN: cubre casos puntuales donde 3FN todavía deja
     una dependencia mal ubicada, típicamente en tablas con varias llaves
     candidatas que se solapan.
   - 4FN trata las listas independientes dentro de la misma tabla: dos datos
     que no tienen nada que ver entre sí metidos en la misma fila, cada uno
     multiplicando al otro.
   - 5FN (project-join) trata las tablas que solo se descomponen bien en tres
     o más tablas a la vez: la dependencia que sobra aparece al recomponerlas
     con varios JOIN, no con uno solo.
   - Son de diseño avanzado y el curso no las desarrolla; alcanza con saber
     que existen y por dónde van.
*/

/*
Reglas de primera forma normal:
1. Las columnas tienen un solo valor
2. El dominio del atributo no puede cambiar
3. Nombre unico para cada columna
4. No importa el orden de los datos
**/

/*
   Las 4 reglas juntas son la definición de 'tabla bien formada'. Dos de ellas
   se malinterpretan seguido:

   1. 'Las columnas tienen un solo valor' — un valor atómico, que no se puede
      partir. Una celda con dos valores separados por coma ya no es un solo
      valor, y eso rompe 1FN. El problema no es estético: cualquier filtro o
      JOIN sobre esa celda obliga a cortar el texto a mano en cada consulta.
   2. 'El dominio del atributo no puede cambiar' — acá 'dominio' es el conjunto
      de valores que la columna admite (su tipo y su rango), y lo que no puede
      cambiar es eso, no el valor de cada fila: el dato concreto cambia todas
      las veces que haga falta. Lo que se rompe es que una columna guarde
      números en unas filas y texto en otras, o que hoy admita fechas y mañana
      cualquier cosa. Dicho corto: puede cambiar el contenido, no las reglas
      del contenido.
   3. 'Nombre único para cada columna' — dentro de la misma tabla. Dos columnas
      con el mismo nombre son ambiguas para el motor y para quien consulta.
   4. 'No importa el orden de los datos' — las filas de una tabla no tienen un
      orden garantizado. Por eso un SELECT solo devuelve resultados ordenados
      si lo pides con ORDER BY; confiar en el orden en que aparecen es el error
      clásico que funciona en el laboratorio y falla en producción.
*/

/* ============================================================================
   1FN ES LA ÚNICA QUE NO SE NEGOCIA (y dónde se rompe a propósito)
   ----------------------------------------------------------------------------
   - De las tres formas que se usan a diario, 1FN es la que menos se relaja: una
     columna con varios valores dentro obliga a partir texto en cada consulta y
     deja el índice sin poder usarse bien.
   - 2FN y 3FN sí se relajan a propósito en analítica: repetir el nombre del
     cliente o el total calculado en varias filas evita JOINs y acelera los
     reportes. Es lo que hace un esquema estrella, y se paga con el riesgo de
     que el dato repetido quede desactualizado.
   - Regla práctica del mundo real: se normaliza hasta 3FN la parte que escribe
     (las aplicaciones que cargan datos) y se desnormaliza aparte la parte que
     lee (los reportes). Son dos necesidades distintas sobre los mismos datos.
============================================================================ */
