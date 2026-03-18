

SELECT *
FROM ventas;

SELECT COUNT(DISTINCT venta_empleado)
FROM ventas;

#Todos los empleados que estan en la tabla de ventas

SELECT *
FROM empleados
#IN permite especificar multiples valores en la clausula where
WHERE ID_empleado IN(
		SELECT DISTINCT venta_empleado
		FROM ventas);