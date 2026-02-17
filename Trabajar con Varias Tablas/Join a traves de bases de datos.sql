#Hacer Joins desde diferentes bases de datos o schemas

USE periodos;

SELECT 
		p.periodo1_id,
		p.Fecha,
		e.Nombre,
		e.Apellido,
		p.local,
		p.Turno_completo
FROM periodo1 p
JOIN default.empleados e
	ON p.ID_empleado = e.ID_empleado;

SELECT 
		p.periodo2_id,
		p.fecha,
		e.nombre,
		e.apellido,
		l.direccion
FROM periodo2 p
JOIN default.empleados e
	ON p.ID_empleado = e.ID_empleado
JOIN default.local l
	ON p.local = l.Letra_zona;

