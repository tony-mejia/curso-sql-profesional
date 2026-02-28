#Update es utilizada para modificar registros existentes en una tabla

SELECT *
FROM ingredientes;

UPDATE ingredientes
SET Ingredientes = "pina", clave_ingrediente = "pin"
WHERE ingredientes_id = 5;

#Actualizaciones de varias filas
SELECT *
FROM ventas

UPDATE ventas
SET venta = 777
WHERE ID_local = 1;