 

/*
 * Subconsulta a comparacion
 SELECT *
FROM empleados
#IN permite especificar multiples valores en la clausula where
WHERE ID_empleado IN(
		SELECT DISTINCT venta_empleado
		FROM ventas);
 */


SELECT *
FROM empleados e
LEFT JOIN ventas v 
	ON v.venta_empleado = e.ID_empleado; 

/*
 Cual es la diferencia de haberlo hecho con la subcolsulta y JOIN?
 R. El JOIN me trae mas informacion, pero esta informacino hay que entenderla 
 */

#Con JOIN tambien me podria traer quienes no vendieron cosa que en la subconsulta con NOT IN no me deja
SELECT *
FROM empleados e
LEFT JOIN ventas v 
	ON v.venta_empleado = e.ID_empleado
WHERE v.ventas_id IS NULL;