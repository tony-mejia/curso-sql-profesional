#Where funciona como un filtro

#Sql es muy especial con el orden. Primero Select, seguido de From y despues Where

#Filtro donde me muestra la columna
Select * from ventas where ID_local = 2;

#Filtro donde no me muestra la columna
Select fecha, venta FROM ventas where ID_local = 2;

#Diferentes operadores
SELECT * FROM ventas WHERE venta < 1000;

SELECT * FROM ventas WHERE venta <= 1000;

SELECT * FROM ventas WHERE ID_local != 2;

