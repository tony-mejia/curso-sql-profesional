/* ============================================================================
   TEMA: Funciones Definidas por el Usuario (Functions / UDF)
   ============================================================================
   La competencia de los procesos almacenados son las funciones.
   
   Diferencia Fundamental: Un Procedimiento (SP) hace acciones complejas y 
   devuelve tablas enteras o nada. Una Función (UDF) hace un cálculo 
   específico y SIEMPRE devuelve un único valor (RETURNS).
============================================================================ */

# Una funcion es codigo que se alimenta de parametros y luego devuelve un valor 

-- 1. CONSULTA BASE (Fase de Prueba)
SELECT 
	venta_empleado,
	AVG(venta)
FROM ventas
GROUP BY venta_empleado;

-- ============================================================================
-- 2. CARACTERÍSTICAS OBLIGATORIAS DE LAS FUNCIONES
-- ============================================================================
/* 
   Para que MySQL confíe en tu función y te deje crearla, debes prometerle 
   qué tipo de impacto tendrá en la base de datos.
*/
/* En las funciones se debe colocar una caracteristica son obligatorias y son 4 opciones:

1. Deterministica (DETERMINISTIC): Devuelve el mismo resultado siempre si le das los mismos parámetros. (Ej. una función que sume 2+2).
2. Modifica Datos SQL (MODIFIES SQL DATA): Usada si adentro de la función hay un UPDATE, INSERT o DELETE.
3. Lectura de Datos SQL (READS SQL DATA): Solo hace SELECTs. Lee las tablas para hacer operaciones matemáticas, pero no altera la información original.
4. No SQL (NO SQL): Indica que la rutina no contiene sentencias SQL (ej. solo hace cálculos matemáticos puros con las variables que le pasaste).
*/

-- ============================================================================
-- 3. CREACIÓN DE LA FUNCIÓN
-- ============================================================================
/*
 CREATE FUNCTION `default`.fn_mejora_empleado(parametro_empleado VARCHAR(7))
-- RETURNS indica el tipo de dato que va a escupir la función al terminar.
RETURNS INT
-- READS SQL DATA es la característica correcta aquí, porque haremos un SELECT a 'ventas'.
READS SQL DATA
BEGIN
	DECLARE factor_mejora DECIMAL(9,1) DEFAULT 0;
	DECLARE ventas_conteo INT;
	DECLARE ventas_total DECIMAL(9,1);

	SELECT 	
		COUNT(*),
		SUM(venta)
	INTO
		ventas_conteo,
		ventas_total
    
    /* ¡OJO TONY! (Apunte de revisión) 
       Aquí te faltó indicar de qué tabla provienen los datos. 
       Debería decir: FROM ventas 
       justo antes del WHERE para que funcione correctamente. */
	WHERE venta_empleado = parametro_empleado;
	
	SET factor_mejora = ventas_total / ventas_conteo * 1.10;
	
-- RETURN (sin la S al final) es el comando que expulsa el resultado hacia afuera.
RETURN factor_mejora;
END*/


-- ============================================================================
-- 4. EJECUCIÓN (El Súper Poder de las Funciones)
-- ============================================================================
/* 
   A diferencia de los procesos almacenados, las funciones se llaman dentro 
   de las consultas. Puedes tratarlas exactamente igual que a un SUM(), 
   un COUNT() o un ROUND().
*/

SELECT 
	ID_empleado,
	Nombre,
	-- Aquí invocamos tu función pasándole el ID de la fila actual:
	fn_mejora_empleado(ID_empleado) AS Objetivo_venta
FROM empleados

# Como las funciones se colocan dentro de las consultas, es iterativa, es decir, calcula fila por fila

/* ============================================================================
   NIVEL PRO (Rendimiento):
   ----------------------------------------------------------------------------
   Como bien notaste, la función es iterativa (fila por fila). 
   Si tu tabla 'empleados' tiene 10 personas, la función buscará en la 
   tabla 'ventas' 10 veces. Si tienes 1 millón de empleados, buscará 
   1 millón de veces. Por eso, en tablas gigantes, las funciones pueden 
   hacer que tu consulta se vuelva muy lenta en comparación con un JOIN.
============================================================================ */
