/* ============================================================================
   TEMA: Transacción Práctica (Alta coordinada de Orden y Pago)
   ============================================================================
   Objetivo: Garantizar que una orden y su pago se registren juntos o no 
   se registre ninguno. Si falla el pago, la orden no debe existir.
============================================================================ */

/*
 En este ejemplo practico vamos a tener 2 instrucciones
 
 1. Instruccion 1: Introducir un nuevo registro a orden
 2. Instruccion 2: Introducir un nuevo registor a pago_orden
 */

# START TRANSACTION es el comando utilizado para iniciar una transaccion
-- Abre el canal seguro. A partir de aquí, nada toca el disco definitivo hasta el COMMIT.
START TRANSACTION;

-- Instrucción 1: Registramos la venta/orden madre
-- Nota: 'default' delega el ID primario, 'curdate()' estampa la fecha del sistema, 
-- y '9999' se asigna como el identificador de esta orden específica.
INSERT INTO orden 
VALUES (default, curdate(),9999,51344,'Verdura Mix',150,0);

-- Instrucción 2: Registramos el pago asociado a esa venta
-- Nota de negocio: El cuarto valor (9999) actúa como llave foránea conectando con la orden anterior.
INSERT INTO pago_orden 
VALUES (default, curdate(),4444,9999,150);

# COMMIT Comando utilizado para confirmar la transaccion actual y hacer que sus cambios sean permanentes 
-- Si ambas instrucciones corrieron sin error, este comando sella los cambios de forma irreversible.
 COMMIT;


/* ============================================================================
   TIPS PRO & TRUCOS DE PRODUCCIÓN
   ============================================================================
   * Truco del ID Dinámico: En sistemas reales nunca escribas el ID a mano ('9999'). 
     Usa la función `LAST_INSERT_ID()` en el segundo INSERT para capturar en 
     automático el ID que generó la orden previa sin riesgo de duplicados.

   * Buena práctica de inserción: Acostumbra listar las columnas:
     `INSERT INTO orden (fecha, cliente_id, ...) VALUES (...)`. Si alguien agrega 
     un campo nuevo a la tabla en el futuro, el INSERT a ciegas fallará.

   * Dato para análisis: Este patrón evita registros "huérfanos". En analítica, 
     una transacción rota genera pagos sin orden asociada que descuadran el 
     cierre contable y las métricas de ingresos.

   * ¿Qué pasa si falla el paso 2?: Si ocurre un error de red o de sintaxis 
     en el pago, MySQL no hace rollback automático por sí solo en consola. 
     Debes mandar manualmente `ROLLBACK;` para limpiar la orden del paso 1.
============================================================================ */