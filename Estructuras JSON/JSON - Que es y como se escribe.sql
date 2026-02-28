#Introduccion a los datos Json

SELECT *
FROM productos;

UPDATE productos
SET caracteristicas = '{"dimension":[5,10,20],"productos":["pizza","burrito"],"cantidad":2}'
WHERE productos_id = 8;