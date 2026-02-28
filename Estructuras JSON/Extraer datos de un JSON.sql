#La funcion JSON_EXTRACT extrae y devuelve los valores deseados del tipo de dato JSON

SELECT productos_id, producto, JSON_EXTRACT(caracteristicas,"$.dimension") 
FROM productos;

SELECT productos_id, producto, JSON_EXTRACT(caracteristicas,"$.cantidad")
FROM productos;

SELECT productos_id, producto, JSON_EXTRACT(caracteristicas,"$.productos") AS productos_incluidos
FROM productos;