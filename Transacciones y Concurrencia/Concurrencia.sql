/* ============================================================================
   TEMA: Concurrencia y Bloqueos de Fila (Row-Level Locking)
   ============================================================================
   Objetivo: Entender cómo el motor gestiona accesos simultáneos sobre un 
   mismo registro, evitando inconsistencias o sobreescrituras cuando varios 
   procesos intentan modificar datos al mismo tiempo.
============================================================================ */

/*
 CONCURRENCIA Es un SGBD es la caracteristica que permite que se puedan ejecutar a la vez varias sentencias
 sobre la base de datos. Si esto no tuviese un control se podria obtener resultados que carezcan de integridad
 */ 

-- Inicia la unidad de trabajo protegida
START TRANSACTION;

-- Modificación atómica sobre el saldo/pago:
-- InnoDB adquiere un bloqueo exclusivo (X-Lock) sobre las filas que cumplan 'orden = 9999'.
-- Ninguna otra sesión puede modificar esa fila hasta que esta transacción termine.
UPDATE pago_orden
SET cantidad = cantidad + 50
WHERE orden = 9999;

-- Libera de inmediato los bloqueos de fila y persiste el nuevo cálculo en disco
COMMIT;


/* ============================================================================
   TIPS PRO & TRUCOS DE PRODUCCIÓN
   ============================================================================
   * Evita el "Lost Update": Hacer `SET cantidad = cantidad + 50` directamente en 
     SQL es la forma correcta y profesional. El error típico de novato es leer 
     el saldo con un SELECT en Python/Node, sumarle 50 en memoria y luego hacer 
     un UPDATE con el total; si dos usuarios hacen eso al mismo segundo, uno pisa 
     al otro y se pierde dinero.

   * Peligro de bloqueo de tabla: Si la columna `orden` NO tiene un índice creado, 
     MySQL no puede aislar solo la fila 9999. Tendrá que escanear y bloquear 
     prácticamente toda la tabla, congelando los pagos de los demás clientes.

   * Cómo lo ve el Analista (MVCC): En MySQL (InnoDB), mientras este UPDATE está 
     bloqueando la fila, las consultas de lectura (`SELECT`) de tus tableros o 
     reportes NO se quedan trabadas. Leen la versión previa confirmada gracias 
     al versionado multiversión (MVCC).
============================================================================ */