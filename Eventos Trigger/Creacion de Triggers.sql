/* ============================================================================
   TEMA: Creación y Ejecución de Triggers (Ejemplo AFTER INSERT)
   ============================================================================
   Objetivo: Automatizar un proceso. Cada vez que alguien registre un pago 
   en la tabla 'pago_orden', el sistema debe ir solito a la tabla 'orden' 
   y actualizar el saldo.
============================================================================ */

# CREATE TRIGGER Comando utilizado para la creacion del TRIGGER. Necesita privilegios de administrador

/*
   Nota técnica sobre los delimitadores:
   Al igual que con los Procedimientos y Funciones, como el Trigger 
   tiene un cuerpo (BEGIN...END), necesitamos cambiar el DELIMITER 
   para que MySQL no corte la lectura a la mitad.
*/
DELIMITER //

-- Sintaxis estándar: CREATE TRIGGER nombre_del_trigger
CREATE TRIGGER pago_after_instert
    -- El Momento (AFTER) y la Acción (INSERT) y sobre qué Tabla (pago_orden)
	AFTER INSERT ON pago_orden
	-- FOR EACH ROW: Significa que si alguien inserta 5 pagos de un golpe, 
    -- el Trigger se ejecutará 5 veces seguidas (una por cada pago).
	FOR EACH ROW 

BEGIN
    -- Cuerpo del Trigger (Lo que debe hacer de forma invisible)
	UPDATE orden
    -- Comando NEW: Hace referencia a la última fila previamente insertada en una tabla.
    -- (Es como decir: "Tráeme la cantidad del pago que apenas se está guardando").
	SET balance = balance + NEW.cantidad 
    
    -- "Encuentra la orden que coincide con el ID de orden del nuevo pago"
	WHERE orden = NEW.orden;
END //

DELIMITER ;


-- ============================================================================
-- EJECUCIÓN (Probando el Trigger)
-- ============================================================================

-- 1. Verificamos cómo está la tabla antes de insertar
SELECT *
FROM pago_orden;

-- 2. Disparamos el Trigger (De forma indirecta)
/* 
   ¡Ojo aquí! Nunca usas el comando CALL con un Trigger. 
   Tú simplemente haces un INSERT normal como cualquier día. El Trigger, que 
   está vigilando en segundo plano, detectará este INSERT y, en menos de un 
   milisegundo, ejecutará su UPDATE a la tabla de órdenes.
*/
INSERT INTO pago_orden
VALUES(default, curdate(), 499, 6792, 100);

/* ============================================================================
   EL PODER DE 'NEW' Y 'OLD' (Apunte avanzado):
   ----------------------------------------------------------------------------
   - En un INSERT: Solo existe `NEW` (porque son datos nuevos llegando).
   - En un DELETE: Solo existe `OLD` (los datos viejos que están por borrarse).
   - En un UPDATE: Existen ambos. Puedes usar `OLD.sueldo` para saber cuánto 
     ganaba el empleado, y `NEW.sueldo` para saber cuánto ganará ahora.
============================================================================ */