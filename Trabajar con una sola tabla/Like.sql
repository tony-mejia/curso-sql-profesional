#Si no conozco bien lo que quiero filtrar de esta manera no me trae nada ya que no hay valor llamado z
SELECT * FROM ventas
WHERE clave_producto = "z";

#Like sirve para buscar patrones, permite busquedas inexactas
SELECT * FROM ventas
	#% Representa 0, uno o multiples caracteres antes
WHERE clave_producto like "%z";

SELECT * FROM ventas
	#% Representa 0, uno o multiples caracteres despues
WHERE clave_producto like "c%";

SELECT * FROM ventas
	#_ Sirve para representar caracteres
WHERE clave_producto like "_l_";

SELECT * FROM ventas
WHERE clave_producto like "__z";

SELECT * FROM empleados
WHERE Nombre LIKE "a%"