#Crear la copia de una tabla como archivarla para revisarla despues. 
#Tipo Backup

SELECT *
FROM ventas v;

CREATE TABLE archivo_ventas AS
SELECT * FROM ventas;

#Con truncate eliminamos los registros de una tabla por completo
#Click derecho sobre la tabla y en herramientas

INSERT INTO archivo_ventas 
SELECT *
FROM ventas
WHERE venta >1000