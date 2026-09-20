/* ============================================================================
   TEMA: Modelo Físico — Del Modelo a las Tablas Reales
   ============================================================================
   Objetivo: Ver por qué el cambio de vocabulario (entidades -> tablas,
   atributos -> columnas) marca un cambio de fase, y qué decisiones dejan de
   ser libres cuando aparece el motor.
============================================================================ */

/*
 Caracteristicas del modelo fico:
 1. A las tablas se les deja de decir entidades y se les llama tablas
 2. A las columnas se les deja de decir atributos y se les llama columnas 
 3. Los nombres de las columnas deben ser compatibles con las bases de datos
 4. Ya se debe especificar los tipos de datos
 **/

/*
   El cambio de nombre de las reglas 1 y 2 no es cosmético: marca en qué fase
   estás parado. Mientras se habla de entidades y atributos todavía se está
   modelando; cuando se habla de tablas y columnas ya hay un motor en el medio.

   - Regla 3, 'compatibles con las bases de datos': acá aparece el motor de
     verdad. 'Compatible' significa respetar sus reglas: sin espacios ni
     acentos en el nombre, sin palabras reservadas del motor (por ejemplo
     'order' o 'select' usadas como nombre de columna) y dentro del límite de
     caracteres que impone. También entra el charset, que es el alfabeto que la
     base acepta.
   - Regla 4, 'ya se debe especificar los tipos de datos': hasta acá un
     atributo era una idea ('el nombre de la empresa'); ahora es un tipo
     concreto del motor (texto, entero, fecha). Elegir mal el tipo no rompe
     nada el primer día: se paga cuando el volumen de datos crece.
*/

/* ============================================================================
   DEL MODELO A LAS TABLAS REALES (MySQL Workbench)
   ----------------------------------------------------------------------------
   El modelo físico no se escribe a mano: se dibuja y la herramienta genera el
   código. En MySQL Workbench ese paso se llama Forward Engineer y transforma el
   modelo físico en las tablas de la base.

   - El camino inverso es Reverse Engineer: de una base existente reconstruye el
     diagrama. Útil cuando heredas una base que nadie documentó.
   - Si después modificas el modelo físico, Workbench no actualiza las tablas
     solo: hay que darle a Sincronizar Modelo para que los cambios se reflejen.
   - Todo lo de esta fase es dependiente del motor, y por eso es lo que más
     cuesta cambiar después: mover un tipo de dato o renombrar una columna ya
     creada no es un dibujo, es una migración sobre datos que ya están en uso.
============================================================================ */
