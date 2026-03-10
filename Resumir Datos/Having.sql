# Having se utiliza para filtrar por campos agrupados, esto es util por que WHERE no lo hace.

/* De esta manaera no es posible
SELECT 
		ID_local,
		clave_producto,
		SUM(venta) as venta_total
FROM ventas
WHERE venta_total > 1500
GROUP BY ID_local, clave_producto
*/

#A diferencia de WHERE, HAVING se coloca posterior a GROUP BY.
SELECT 
		ID_local,
		clave_producto,
		SUM(venta) as venta_total
FROM ventas
GROUP BY ID_local, clave_producto
HAVING venta_total > 1500;
