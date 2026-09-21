/* ============================================================================
   TEMA: Motores de Almacenamiento (Storage Engines)
   ============================================================================
   Objetivo: Entender qué decide el motor de almacenamiento, por qué InnoDB es
   el default de MySQL y cómo leer la lista de motores con SHOW ENGINES.
============================================================================ */

# El motor de almacenamiento es el software que se utiliza para crear, leer y actulizar los datos entre el disco y la memoria ram

/*
   El motor define cómo se guardan las filas y los índices, si hay
   transacciones, cómo se bloquean las filas al escribir y qué se puede
   recuperar después de una caída. Cambiar de motor cambia esas garantías, no
   solo la velocidad.

   La elección es por tabla, no por base ni por servidor: dos tablas del mismo
   esquema pueden usar motores distintos. El servidor solo fija el default que
   se aplica cuando la sentencia no lo dice.
*/

# El motor por default que se utiliza en MySQL es InnoDB 

/*
   InnoDB es el default desde MySQL 5.5; antes de esa versión el default era
   MyISAM. Que sea el default no obliga a cada tabla: la sentencia CREATE TABLE
   puede apartarse con ENGINE= y elegir ahí el motor para esa tabla en
   particular.
*/

# SHOW ENGINES: Muestra la informacion de estado sobre los motores de almacenacmiento del servidor 

SHOW ENGINES;

/* ============================================================================
   INNODB POR DEFECTO: QUÉ MIRAR ANTES DE ELEGIR MOTOR
   ----------------------------------------------------------------------------
   - SHOW ENGINES devuelve una fila por motor. Support vale YES, NO o DEFAULT:
     DEFAULT marca el motor por omisión del servidor, no una garantía de
     calidad. Las columnas Transactions, XA y Savepoints dicen qué soporta cada
     motor.
   - InnoDB llega con transacciones y bloqueo por fila, y por eso es el punto de
     partida sensato para tablas que se escriben. Un motor sin transacciones no
     permite revertir a medias: una escritura interrumpida puede dejar la tabla
     en un estado parcial.
   - Cambiar el motor de una tabla existente no es gratis: ALTER TABLE ENGINE=
     reescribe la tabla y sus índices. Con datos en producción se planifica.
   - Antes de elegir un motor distinto de InnoDB, confirmar que hace falta. En
     MySQL 8.0 los objetos del sistema ya viven en InnoDB.

   ----------------------------------------------------------------------------
   NIVEL PRO: CONSULTAR LOS MOTORES COMO TABLA (information_schema.ENGINES)
   ----------------------------------------------------------------------------
   SHOW ENGINES es cómodo a mano, pero su salida no se puede filtrar ni unir.
   information_schema.ENGINES expone los mismos datos como una tabla consultable
   y es la vía que conviene dentro de un script:
   -- Estructura ilustrativa (ajusta las columnas que quieras mostrar):
   -- SELECT ENGINE, SUPPORT FROM information_schema.ENGINES
   --     WHERE SUPPORT = 'DEFAULT';
============================================================================ */
