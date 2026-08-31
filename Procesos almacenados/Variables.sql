/* ============================================================================
   TEMA: Variables Locales dentro de Procedimientos Almacenados (DECLARE)
   ============================================================================
   Objetivo: Crear variables que "viven" exclusivamente dentro del 
   procedimiento almacenado. Se utilizan para guardar datos temporales, 
   hacer cálculos matemáticos y luego mostrar o usar el resultado.
============================================================================ */

-- ============================================================================
-- 1. LA LÓGICA MATEMÁTICA (Fase de Prueba)
-- ============================================================================
/*
   Aquí primero pruebas que tu lógica matemática funciona. 
   El promedio de ventas se puede sacar directamente con AVG, o dividiendo 
   la suma total entre el conteo de filas. Ambas dan el mismo resultado.
*/
# Vamos a meter variables dentro del proceso almacenado
 
 SELECT 
 	AVG(venta)
 FROM ventas;
 
 SELECT 
 	SUM(venta)/count(*)
 FROM ventas;
 
-- ============================================================================
-- 2. EL PROCEDIMIENTO CON VARIABLES INTERNAS
-- ============================================================================
/*
   El comando DECLARE:
   Se usa para crear variables locales. Obligatoriamente, todos los DECLARE 
   deben ir justo después de la palabra BEGIN, antes de cualquier SELECT o UPDATE.
*/
 
 /*CREATE PROCEDURE `default`.sp_proceso_mejora()
BEGIN
    -- Declaramos 3 variables e indicamos qué tipo de dato van a almacenar.
    -- La cláusula DEFAULT le asigna un valor inicial de 0 para que no sea NULL.
	DECLARE factor_mejora DECIMAL(9,1) DEFAULT 0;
	DECLARE ventas_conteo INT;
	DECLARE ventas_totales DECIMAL(9,1);

    -- Usamos INTO para atrapar los resultados de esta consulta y 
    -- guardarlos directamente en nuestras variables recién creadas.
	SELECT 
		COUNT(*),
		SUM(venta)
	INTO 
		ventas_conteo,
		ventas_totales
	FROM ventas;
	
    -- Hacemos la matemática: 
    -- Calculamos el promedio y lo multiplicamos por 1.10 (un aumento del 10%).
    -- Usamos SET porque le estamos asignando un nuevo valor a la variable.
	SET factor_mejora = ventas_totales/ventas_conteo * 1.10;
	
    -- Finalmente, mostramos el resultado en pantalla
	SELECT factor_mejora;
END*/
 
-- ============================================================================
-- 3. EJECUCIÓN
-- ============================================================================
 CALL sp_proceso_mejora();

/* ============================================================================
   DIFERENCIA CLAVE PARA EL FUTURO (Variables '@' vs 'DECLARE'):
   ----------------------------------------------------------------------------
   - Variables de sesión (@suma): Existen fuera del procedimiento. Viven en 
     tu sesión y cualquier otra consulta puede verlas y modificarlas.
   - Variables locales (DECLARE suma): Nacen en el BEGIN y mueren en el END. 
     Son privadas y seguras. Nadie fuera de este procedimiento puede verlas ni 
     alterar su valor. Siempre que puedas, prefiere usar DECLARE.
============================================================================ */