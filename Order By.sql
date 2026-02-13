#Order by es utilizada para ordenar los registros

	#A-Z
SELECT * from empleados
order by nombre;

	#Z-A
SELECT * from empleados
order by nombre DESC;

	#Filtros y ordenamiento
SELECT * from empleados
WHERE Apellido like "%ez"
ORDER BY apellido desc;