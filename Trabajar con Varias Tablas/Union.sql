#Sirve para unir dos consultas y y convertirla en 1.
#Utilizada para para combinar los resultados de dos mas clausulas SELECT

SELECT producto
FROM productos
UNION
SELECT ingredientes
FROM ingredientes;

#La regla es no tener una cantidad de columnas 