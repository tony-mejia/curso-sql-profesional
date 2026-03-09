# Agregaciones son operaciones matematicas que se hacen dentro de la tabla 
# Sumas, Promedios, Maximos, Minimos y Conteos

SELECT *
FROM ventas;

#Cual fue la venta mas grande de todas?
#Funcion Max: calcula el maximo entre los valores de una columna

SELECT MAX(venta)
FROM ventas;

#Cual fue el empleado que hizo esa venta mas grande?

SELECT 
    	venta,
    	venta_empleado,
    	Fecha
FROM ventas
ORDER BY venta DESC
LIMIT 1;

#Suma de todas las ventas

SELECT 
		SUM(venta)
FROM ventas;

# La funcion COUNT devuelve el numero de registros de una consulta de seleccion
# Los valores Null no se cuentan

SELECT 
		COUNT(venta_empleado)
FROM ventas;

# Funcion DISTINCT Devuelve solo los valores diferentes.
# Al usarlo con COUNT, contara los datos que no estan duplicados.

SELECT 
		COUNT(DISTINCT venta_empleado) as empleados_diferentes
FROM ventas;

# LA funcion AVG devuelve el valor promedio de una expresion 
# Los valores null se ignoran

SELECT 
		AVG(venta)
FROM ventas;