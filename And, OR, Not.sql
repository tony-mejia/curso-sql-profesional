#AND sirve para ligar condiciones, pero se deben cumplir todas las condiciones

Select * from ventas where ID_local = 2 AND clave_producto = "pzz";

#OR sirve para ligar condiciones, con que una condicion se cumpla

Select * from ventas where ID_local = 2 OR clave_producto = "pzz";

Select * from ventas where ID_local = 2 OR ID_local = 4;

#Filtro con Where Not, funciona como el operador !=

Select * from ventas where not clave_producto = "pzz";

#Para negar varias condiciones se debe colocar not en cada una de ellas

Select * from ventas where not clave_producto = "pzz" and not ID_local = 2;