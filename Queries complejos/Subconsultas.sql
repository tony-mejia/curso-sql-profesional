
#Consulta para sacar los empleados cuya edad es mayor al promedio
SELECT *
FROM empleados
WHERE Edad >
	(SELECT 
			AVG(Edad)
	FROM empleados);

