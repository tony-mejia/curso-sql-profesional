#Agregar un registro en una segunda tabla cuando en la primera ya se hizo.

SELECT *
FROM ventas;

INSERT INTO ventas(ID_local,clave_producto,venta)
VALUES (2,"pzz",233);

#SELECT LAST_INSERT_ID()
#Solo esta tomando en cuenta la ultima incersion

INSERT INTO ventas_detalle 
#Si no se especifican las columnas, sql lo que va a esperar es que la fila debe tener los detalles de todas las columnas
#No se puede saltar ni uno
VALUES (LAST_INSERT_ID(),"Llevar");