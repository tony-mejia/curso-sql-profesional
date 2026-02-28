#Introduccion a las subconsultas

SELECT *
FROM ventas

#Se puede utilizar una consulta de manera de filtro

SELECT id_local
FROM local
WHERE Letra_zona = "D";

UPDATE archivo_ventas
SET venta = venta * 1.16
WHERE  ID_local =
		(SELECT id_local
		FROM local
		WHERE Letra_zona = "D");

UPDATE archivo_ventas
SET venta = venta * 1.16
WHERE  ID_local IN
		(SELECT id_local
		FROM local
		WHERE Letra_zona IN ("D","C"));