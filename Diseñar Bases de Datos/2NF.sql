/* ============================================================================
   TEMA: Segunda Forma Normal (2FN) y Dependencia Parcial
   ============================================================================
   Objetivo: Entender qué es la dependencia parcial, nombre que aparece en la
   regla 2 y nunca se explica, y por qué esta forma normal solo puede fallar
   cuando la llave primaria es compuesta.
============================================================================ */

# La segunda forma normal construye sobre la primera forma normal

/*
Reglas segunda forma normal
1. Cumplir con la primer forma normal
2. No debe de haber dependencia parcial 
 **/

/*
   La regla 2, 'no debe de haber dependencia parcial', es la que casi nunca se
   explica, y sin ella 2FN no se termina de entender.

   Dependencia parcial significa que una columna que NO es llave depende de una
   PARTE de la llave primaria, no de la llave completa. Eso solo puede pasar
   cuando la llave es compuesta, es decir, cuando está formada por dos o más
   columnas.

   Ejemplo inventado para ilustrar (sin tabla real, solo la idea): si una tabla
   se identifica con la combinación de (pedido, producto) y además guarda el
   nombre del producto, ese nombre depende solo de 'producto', que es una parte
   de la llave; no depende del pedido. Guardarlo ahí obliga a repetir el nombre
   en todas las filas donde aparezca ese producto.

   El límite, que conviene tener claro: si la llave primaria es de una sola
   columna, no puede existir dependencia parcial y 2FN se cumple sola. Por eso
   el problema aparece siempre asociado a llaves compuestas.

   Precisión fina, para no repetirla mal: la regla se mide sobre las llaves
   candidatas (las columnas que podrían ser llave), no solo sobre la que
   elegiste como primaria. Una tabla con llave primaria de una sola columna y
   además una clave única compuesta todavía puede fallar 2FN.
*/

# Dependendia funcional: Todas las columnas dependen de la llave primaria

/*
   Dependencia funcional: columna Y depende funcionalmente de la llave X
   cuando, conocido X, Y queda determinado: no pueden existir dos filas con el
   mismo X y distinto Y.

   Esa definición no es teoría suelta, es la herramienta con la que se detectan
   los dos problemas de las formas normales siguientes:

   - Si Y depende de una PARTE de X, hay dependencia parcial: falla 2FN.
   - Si Y depende de otra columna que no es X, hay dependencia transitiva:
     falla 3FN.

   Por eso 2FN y 3FN se explican casi siempre juntas: son dos preguntas
   distintas sobre la misma dependencia funcional.
*/

/* ============================================================================
   2FN DEJA DE SER UN PROBLEMA CON UNA CLAVE SUBROGADA
   ----------------------------------------------------------------------------
   - La dependencia parcial solo existe si la llave primaria es compuesta. En la
     práctica, casi todas las tablas se diseñan con una clave subrogada: una
     columna ID numérica autoincremental, artificial, que no viene del negocio.
   - Con la llave en una sola columna, 2FN se cumple sola: no hay ninguna parte
     de la llave de la que otra columna pueda depender. El diseño ya nace en
     2FN.
   - Por eso la recomendación de producción es usar un ID autoincremental en
     lugar de datos del mundo real como clave (documento, correo): el dato real
     cambia con el tiempo, el ID no, y de paso 2FN queda resuelta de entrada.
   - La llave compuesta sigue teniendo su lugar: es correcta en las tablas de
     relación entre dos entidades, donde la llave ES el par. Ahí sí hay que
     revisar la dependencia parcial a mano.
============================================================================ */
