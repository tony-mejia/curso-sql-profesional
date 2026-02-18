#Natural Joins no requeire que se especifique sobre que columnas se va a hacer el join, sobre donde se van a unir.
#SQL va a buscar columnas que se llamen igual y sobre esas esas se va  a hacer la union.
#Que pasa si no hay dos columnas que se llamen igual?. 


#Ejemplo donde si funciona 
SELECT *
FROM ventas v 
NATURAL JOIN local l;

#Ejemplo donde no funciona 
SELECT *
FROM ventas v 
NATURAL JOIN empleados e;

#Misma union del tipo INNER o LEFT JOIN. En este caso la clausula ON se refiere a todas las columnas en comun con las tablas.