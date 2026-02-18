USE `default`;

#Usada para hacer coincidir una sola columna de las tablas que se van a unir.

#En lugar de hacer esto
SELECT *
FROM ventas v
JOIN local l
	ON 	v.ID_local = l.ID_Local;

#Using sirve para hacer coincidir una sola columna de las tablas que se van a unir 
SELECT *
FROM ventas v
JOIN local l
	USING(ID_local);
#Solo sirve cuando tenemos las dos mismos nombres de columna 