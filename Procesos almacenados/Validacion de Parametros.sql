/* ============================================================================
   TEMA: Procedimientos Almacenados para Actualizar Tablas (UPDATE) y Validaciones
   ============================================================================
   Hasta ahora usábamos SPs para consultar (SELECT). Aquí damos el salto a la 
   manipulación de datos (DML). 
   
   ¿Por qué usar un SP para actualizar?
   Por seguridad. Evitas que un empleado ejecute un UPDATE sin WHERE por error 
   (y borre toda la tabla). Al obligarlos a usar el procedimiento, garantizas 
   que el WHERE (ID_empleado = ...) siempre se ejecute.
============================================================================ */

-- ============================================================================
-- 1. SP PARA ACTUALIZAR TABLAS (Uso Básico)
-- ============================================================================

# Vamos a utilizar un proceso almacenado para actualizar tablas 

/*
 CREATE PROCEDURE `default`.actualizar_empleado(parametro_empleado VARCHAR(7), parametro_edad TINYINT, parametro_telefono VARCHAR(8))
BEGIN
	UPDATE empleados e
	SET 
		e.edad = parametro_edad,
		e.telefono = parametro_telefono
	WHERE e.ID_empleado = parametro_empleado;
END*/

/* 
   APUNTE PRO: Fíjate que en tu CALL el teléfono no tiene comillas (01234567). 
   Como tu parámetro pide un VARCHAR (texto), siempre es mejor enviarlo 
   con comillas ('01234567'). Si lo mandas como número, SQL podría quitarle 
   el cero a la izquierda automáticamente.
*/
CALL actualizar_empleado('1111222', 63, 01234567);


-- ============================================================================
-- 2. VALIDACIÓN DE PARÁMETROS (Programación Defensiva)
-- ============================================================================
/*
   Aquí le decimos a la base de datos: "Antes de hacer el UPDATE, revisa si 
   la edad es lógica para nosotros. Si no lo es, cancela la operación y lanza 
   una alerta". A esto se le llama "Programación Defensiva".
*/

# Y vamos a validar parametros. Vamos a actulizar la tabla pero vamos a ponerle condiciones

/*
 CREATE PROCEDURE `default`.actualizar_empleado(parametro_empleado VARCHAR(7), parametro_edad TINYINT, parametro_telefono VARCHAR(8))
BEGIN
	IF parametro_edad < 18 OR parametro_edad > 60 THEN 
		-- La función SIGNAL funciona igual que un "throw exception" en programación.
		SIGNAL SQLSTATE '22003'
		SET MESSAGE_TEXT = 'Edad fuera de rango';
	END IF;
	
	-- Si el IF anterior se activa, el procedimiento se "rompe" ahí mismo y 
	-- este UPDATE jamás llega a ejecutarse. Tu información queda a salvo.
	UPDATE empleados e
	SET 
		e.edad = parametro_edad,
		e.telefono = parametro_telefono
	WHERE e.ID_empleado = parametro_empleado;
END*/


-- ============================================================================
-- 3. LANZAMIENTO DE ERRORES PERSONALIZADOS (SIGNAL)
-- ============================================================================

# SIGNAL SQLSTATE Proporciona control sobre la informacion de retorno de un error o advertencia al llamar un proceso almacenado. Hay varios diferntes a SIGNAL SQLSTATE

CALL actualizar_empleado('1111222', 65, 01234567);

# Error en consola: SQL Error [1644] [22001]: Data truncation: Edad fuera de rango

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Códigos SQLSTATE: Son un estándar universal de errores en bases de datos. 
     El código '22003' significa específicamente "Valor numérico fuera de rango".
     Otro muy común que puedes usar para errores genéricos creados por ti es el 
     '45000' (que significa "Excepción no controlada definida por el usuario").
============================================================================ */