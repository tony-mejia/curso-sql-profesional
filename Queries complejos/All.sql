#ALL Todo significa que la condicion sera verdadera solo si la operacion es verdadera para todos los valores en el rango
#Sirve para hacer una comparacion de dos toablas, una de ella contra toda la otra tabla

SELECT venta
FROM ventas 
WHERE ID_local = 2;

SELECT MAX(venta)
FROM ventas 
WHERE ID_local = 2;

SELECT *
FROM ventas 
WHERE venta > (
	SELECT MAX(venta)
	FROM ventas
	WHERE ID_local = 2);

SELECT *
FROM ventas 
WHERE venta > ALL(
	SELECT venta
	FROM ventas
	WHERE ID_local = 2);

#Otro Ejercicio

SELECT *
FROM ventas
WHERE ID_local = 4;

SELECT *
FROM ventas
WHERE venta < ALL(
	SELECT venta
	FROM ventas
	WHERE ID_local = 4);


