#

SELECT * 
FROM ventas v
RIGHT JOIN empleados e
	ON v.venta_empleado = e.ID_empleado;
	
SELECT * 
FROM ventas v
LEFT JOIN empleados e
	ON v.venta_empleado = e.ID_empleado;