#JOIN Se utiliza para combinar filas de dos o más tablas, basadas en una columna relacionada entre ellas.

SELECT 
	v.ventas_id,
	v.Fecha,
	l.direccion,
	v.clave_producto,
	v.venta,
	e.nombre,
	e.apellido
FROM ventas v
JOIN local l 
	ON v.ID_local = l.ID_Local 
JOIN empleados e 
	ON v.venta_empleado  = e.ID_empleado;