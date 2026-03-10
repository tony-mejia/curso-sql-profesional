#GRUOP BY nos permite agrupar los registros en alguna operacion de resumen como contar, maximos, minimos, suma o promedio

SELECT 
		SUM(venta),
		ID_local
FROM ventas
GROUP BY ID_local;

#Se coloca posterios a la clausula FROM o WHERE en caso de estar presentes.
#Se debe agrupar a partir de una de las columnas llamadas es la clausula SELECT.
#Es usada en funciones de agregacion, count, max, min, sum, avg.

SELECT 
		SUM(venta),
		venta_empleado
FROM ventas
GROUP BY venta_empleado
ORDER BY SUM(venta) DESC;