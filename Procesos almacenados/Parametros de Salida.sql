/* ============================================================================
   TEMA: Procedimientos Almacenados con Parámetros de Salida (OUT)
   ============================================================================
   Hasta ahora vimos parámetros de entrada (IN). Aquí introducimos los 
   parámetros de salida (OUT). Sirven para que el procedimiento ejecute un 
   cálculo y lo guarde en la memoria del servidor para usarlo después, 
   en lugar de solo escupir una tabla visual en la pantalla.
============================================================================ */

# Un pooceso que calcule las ventas por local 
 
# INTO Es basicamente los dos parametros, donde se van a guardar nuestros datos

/*
 CREATE PROCEDURE `default`.sp_ventas_local(IN parametro_local_id INT, OUT parametro_suma_venta INT)
BEGIN
	-- La cláusula INTO toma el resultado de tu SELECT y lo "inyecta" 
	-- silenciosamente dentro de las variables que declaraste arriba.
	SELECT 
		ID_local,
		SUM(venta)
	INTO
		parametro_local_id,
		parametro_suma_venta
	FROM ventas
	WHERE ID_local = parametro_local_id;
END*/

/* 
   Nota de repaso: Este primer CALL marcará error (como vimos hace dos lecciones) 
   porque no le estás enviando los 2 parámetros obligatorios.
*/
CALL sp_ventas_local();


-- ============================================================================
-- EJECUCIÓN CON VARIABLES DE SESIÓN (@)
-- ============================================================================
/*
   Para poder capturar el valor de un parámetro OUT, necesitamos crear una 
   "cubeta" temporal en MySQL. Esas cubetas se llaman Variables de Sesión y 
   siempre llevan una arroba (@) al inicio.
*/

-- 1. Preparamos nuestras variables
SET @param_local = 1;
SET @suma_ventas = 0; -- Esta variable entra vacía/en cero, lista para ser llenada por el SP.

-- 2. Ejecutamos el procedimiento pasándole las variables (nuestras "cubetas")
CALL sp_ventas_local(@param_local, @suma_ventas);

-- 3. Consultamos nuestra variable, la cual ahora ya contiene el total calculado
SELECT @suma_ventas;


/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Tipos de parámetros: 
     * IN: Datos que tú le mandas al procedimiento (solo lectura).
     * OUT: Datos que el procedimiento te devuelve a ti (escritura).
     * INOUT: Hace ambas cosas.
   - El ciclo de vida del '@': Todo lo que guardes en una variable como 
     @suma_ventas existirá en la memoria ÚNICAMENTE mientras tengas tu 
     conexión abierta. Si cierras tu gestor de base de datos y lo vuelves 
     a abrir, la variable @suma_ventas dejará de existir.
============================================================================ */