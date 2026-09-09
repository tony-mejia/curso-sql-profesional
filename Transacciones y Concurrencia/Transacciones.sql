/* ============================================================================
   TEMA: Transacciones y Propiedades ACID
   ============================================================================
   Objetivo: Comprender el concepto de unidad de trabajo indivisible en MySQL
   y cómo las propiedades ACID garantizan la consistencia absoluta de los
   datos ante fallos o accesos concurrentes.
============================================================================ */

# Transacciones: Conjutnto de ordenes que se ejecutan formando una unidad  de trabajo donde todas las instrucciones deben tener exito para que la unidad de trabajo se considere que tiene exito

# Se asegura la consistencia de los datos

# Las transacciones tiene 4 propiedades y por sus siglas en ingles se les llaman 'ACID'
/*
 1. Atomicidad: Las transacciones son todo o nada
 2. Consistencia: Solo se gurdan datos valiosos 
 3. Aislamiento: Las transacciones no se afectan entres si
 4. Durabilidad: Los datos escritos no se perderan
  */


-- ============================================================================
-- SINTAXIS PRÁCTICA (Flujo de Ejecución)
-- ============================================================================

START TRANSACTION;

-- Operación 1: Descontar saldo
UPDATE cuenta SET saldo = saldo - 500 WHERE id_cuenta = 1;

-- Operación 2: Acreditar saldo
UPDATE cuenta SET saldo = saldo + 500 WHERE id_cuenta = 2;

-- Si ambas operaciones fueron exitosas:
COMMIT;

-- Si ocurrió cualquier error en el camino:
-- ROLLBACK;


/* ============================================================================
   APUNTE AVANZADO / NIVEL PRO (Mundo Real & Millones de Filas)
   ============================================================================
   
   1. La Trampa del COMMIT Implícito (DDL mortal):
      En MySQL, ciertas sentencias ejecutan un COMMIT silencioso e irreversible,
      destruyendo tu transacción aunque no hayas llamado a COMMIT explícitamente.
      Sentencias como CREATE TABLE, ALTER TABLE, DROP TABLE o TRUNCATE fuerzan 
      un commit inmediato; nada de lo ejecutado antes de ellas se podrá revertir.

   2. El Costo del Aislamiento (Locks y Deadlocks en tablas masivas):
      Durante una transacción, las filas afectadas quedan bloqueadas para escritura.
      Dejar transacciones abiertas innecesariamente mientras corre código externo 
      (por ejemplo, scripts lentos en Python o APIs) colapsa la cola de conexiones 
      y desata Deadlocks (bloqueos mutuos entre procesos).
      * Regla de oro: Mantener las transacciones lo más cortas posible.

   3. Durabilidad vs. Rendimiento en Disco (innodb_flush_log_at_trx_commit):
      Para garantizar durabilidad estricta (valor 1), MySQL fuerza una escritura 
      física a disco en cada COMMIT. En sistemas de alto tráfico que procesan 
      miles de operaciones por segundo, esto genera cuellos de botella en I/O. 
      Muchas arquitecturas de datos sacrifican esto usando el valor 2 para ganar 
      velocidad, asumiendo el riesgo controlado de perder hasta 1 segundo de datos 
      ante un corte eléctrico del servidor.

   4. Impacto en Analítica (Undo Logs):
      Lanzar una consulta masiva de lectura pesada dentro de una transacción 
      abierta obliga al motor InnoDB a retener versiones históricas de cada fila 
      que se modifique en paralelo, disparando el uso de espacio en disco (Undo Tablespace).
============================================================================ */