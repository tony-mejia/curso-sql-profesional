#Expresiones regulares: (comunmente llamadas regex) son patrones de simbolos y caracteres utilizados para hacer match con una busqueda.

SELECT * FROM empleados
where apellido like "%ez";

#si bien like es util esta limitado en filtros de texto.

#REGEXP trae como retorno los registros que coincidan con el pátron realizado con expresiones regulares.
#En este momento se veran 3 reglas pero hay muchas mas.

SELECT * FROM empleados
	#Que contiene
where apellido regexp "ez";

SELECT * FROM empleados
	#Que impieza
where apellido regexp "^A";

SELECT * FROM empleados
	#Que termina
where apellido regexp "ez$";

SELECT * FROM empleados
	#Que contiene estos caracteres
where apellido regexp "ez|iz|b%";