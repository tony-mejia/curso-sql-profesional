#Limit es utilizado para especificar el numero de registros que obtendremos como retorno al ejecutar la consulta

SELECT * from ventas 
LIMIT 5;

#No me muestra los primero 5 y luego me muestra los siguientes 9
SELECT * from ventas 
LIMIT 5,9;