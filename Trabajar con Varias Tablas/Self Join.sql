#

SELECT
		e.ID_empleado,
		e.Nombre,
		e.Apellido,
		e.Telefono,
		e.Edad,
		e.Domicilio,
		p.Nombre as Gerente,
		p.Apellido  as ApellidoGerente
FROM empleados e
JOIN empleados p
	ON e.ID_Gerente = p.ID_empleado 