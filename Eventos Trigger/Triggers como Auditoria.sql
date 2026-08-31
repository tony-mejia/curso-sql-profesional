/* ============================================================================
   TEMA: Triggers aplicados a Tablas de Auditoría (Logs)
   ============================================================================
   El uso más profesional de los Triggers es rastrear el historial de 
   movimientos. Como "los triggers no dejan evidencia" por sí solos, nosotros 
   debemos obligarlos a dejar una "huella" o bitácora de lo que hicieron.
============================================================================ */

#Se pueden usar los triggers en temas de auditoria
#Ejmeplo: cuando alguien modifique la orden pago tambien se haga un regitro en auditoria de pagos para decir "hubo modificacion"

DELIMITER //

CREATE TRIGGER pago_after_instert_auditoria
	AFTER INSERT ON pago_orden
	FOR EACH ROW 

BEGIN
    -- ACCIÓN 1: Actualizar la lógica del negocio (El balance)
	UPDATE orden
	SET balance = balance + NEW.cantidad -- Comando NEW, Hace referencia a la ultima fila previamente insertada en una tabla
	WHERE orden = NEW.orden;

    -- ACCIÓN 2: Dejar la evidencia (La Auditoría)
    /*
       El gran poder del bloque BEGIN...END es que puedes meter tantas 
       instrucciones como quieras. Aquí estamos usando los datos 'fantasma' 
       (NEW) no solo para sumar el balance, sino para llenar el reporte 
       de auditoría con la fecha, cantidad y el tipo de operación ('INSERT').
    */
	INSERT INTO auditoria_pagos 
	VALUES(NEW.ID_pago, NEW.ID_pago, NEW.ORDEN, NEW.FECHA, NEW.Cantidad, 'INSERT', CURDATE());
END //

DELIMITER ;


-- ============================================================================
-- EJECUCIÓN Y VALIDACIÓN
-- ============================================================================
/* 
   El usuario hace su trabajo normal (registra un pago). No sabe que, tras 
   bambalinas, el Trigger acaba de actualizar el balance y registrar el log.
*/
INSERT INTO pago_orden
VALUES(default, curdate(), 501, 6792, 25);


/* 
   El administrador (tú) revisa la tabla de auditoría para comprobar que 
   el "espía" (Trigger) dejó el reporte correctamente.
*/
SELECT *
FROM auditoria_pagos;

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Nivel Dios (Auditoría de UPDATEs): Si estuvieras haciendo un Trigger para 
     AFTER UPDATE, tu INSERT a la tabla de auditoría podría guardar tanto 
     el valor viejo como el nuevo para saber exactamente qué cambió:
     VALUES(..., OLD.Cantidad, NEW.Cantidad, 'UPDATE', CURDATE());
============================================================================ */