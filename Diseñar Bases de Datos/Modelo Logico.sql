/* ============================================================================
   TEMA: Modelo Lógico — Las 4 Reglas
   ============================================================================
   Objetivo: Ver qué decide cada una de las 4 reglas del modelo lógico y por
   qué la última (ser agnóstico al motor) explica el lugar que ocupa esta fase.
============================================================================ */

/*
 Reglas del modleo logico 
 1. Definir atributos (nombre de columnas) y llaves primarias
 2. Identificar cual es la relacion entre llaves primarias y llaves foraneas dentro de cada tabla 
 3. Nombre de las columnas amigables para el usuario
 4. Es agnostico a bases de datos
 */

/*
   Las 4 reglas están bien planteadas; cada una esconde una decisión que
   conviene tener presente.

   1. Definir atributos y llaves primarias — los atributos son el contenido de
      cada entidad y la llave primaria es el dato que identifica cada fila sin
      ambigüedad. Esto se decide en este modelo, no en el motor.
   2. Relacionar llaves primarias y foráneas — es la regla que sostiene todo lo
      demás. La llave foránea es la llave primaria de otra tabla escrita como
      columna en esta: así queda declarada la relación entre las dos. No es un
      dato más, es el dato que conecta.
   3. Nombres amigables — el nombre lo va a leer una persona dentro de seis
      meses, o una herramienta de BI. 'Amigable' no quiere decir 'corto',
      quiere decir que se entiende sin preguntar.
   4. Agnóstico a bases de datos — el modelo lógico no depende del motor. Si
      mañana se migra de MySQL a otro motor, este modelo no cambia; lo que
      cambia es el modelo físico.
*/

/* ============================================================================
   AGNÓSTICO AL MOTOR, NO AL NEGOCIO
   ----------------------------------------------------------------------------
   - 'Agnóstico' cubre la tecnología, no el contenido: la base se puede migrar
     de motor, pero un negocio modelado mal sigue mal en cualquier motor.
   - El nombre de una columna es una decisión de esta fase y es de las más
     caras de revertir: cuando ya está en el modelo físico, vive también en las
     consultas, las vistas y los reportes que la usan.
   - A esta altura todavía no existe ni una tabla. Si algo no cierra acá, todo
     lo que venga después arrastra el error.
============================================================================ */
