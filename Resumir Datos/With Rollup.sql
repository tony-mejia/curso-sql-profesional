# WITH ROLLUP Es una modificador utilizado para producir resumenes de las salidas de informacion de los distintos grupos.

SELECT
		ID_local,
		SUM(venta) as venta_total
FROM ventas
GROUP BY ID_local WITH ROLLUP


#Ejemplo con mas granularidad
SELECT
		ID_local,
		clave_producto,
		SUM(venta) as venta_total
FROM ventas
GROUP BY ID_local, clave_producto WITH ROLLUP;

#Para analisis en SQL va bien, para exportarlo a excel o para visualizacion de datos es incorrecto, porque va a tocar limpiar tablas.