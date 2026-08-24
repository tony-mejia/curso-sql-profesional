/* ============================================================================
   TEMA: Estructura Condicional CASE WHEN (Múltiples situaciones)
   ============================================================================
   Sirve cuando tienes varias situaciones o categorías que quieres cubrir.
   A diferencia del IF(), el CASE es el estándar ANSI SQL, lo que significa 
   que este mismo código te funcionará en Oracle, SQL Server, PostgreSQL, etc.
============================================================================ */

-- ============================================================================
-- 1. APLICACIÓN DE CASE WHEN
-- ============================================================================
/*
   ¿Cómo funciona la lectura?
   Pasa por las condicionales en estricto orden de arriba hacia abajo y 
   devuelve un valor cuando se cumpla la primera de ellas. Después de eso, 
   dejará de leer las siguientes condiciones para esa fila en específico.
*/
SELECT
	*,
	CASE
		WHEN venta > 1300 THEN "bono jogoso"
		WHEN venta > 1000 THEN "bono honesto"
		WHEN venta > 500 THEN "bono chiquito"
		ELSE "Esfuerzate mas"
	END AS BONO
FROM ventas v;

/* ============================================================================
   APUNTE DE REPASO TONY (¡REGLA DE ORO!):
   ----------------------------------------------------------------------------
   Como dato importante, siempre debemos escribir las cosas escalonadas 
   (de mayor a menor o de menor a mayor, dependiendo de la lógica).
   
   El porqué (La trampa del CASE):
   Si hubieras puesto `WHEN venta > 500 THEN "bono chiquito"` en la primera 
   línea, una venta de $1,500 caería ahí primero. SQL diría "¡Se cumple, 1500 
   es mayor a 500!" y le asignaría el "bono chiquito", deteniendo la lectura y 
   robándole su "bono jugoso" al empleado. 
   
   ¡En el CASE, el orden de los factores SÍ altera el producto!
============================================================================ */