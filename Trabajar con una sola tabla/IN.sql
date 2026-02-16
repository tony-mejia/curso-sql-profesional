
Select * from ventas 
WHERE  clave_producto = "clz" or clave_producto = "pzz" or clave_producto = "qsd";

#in es un atajo para varias condiciones or. Permite especificar varios valores en la clausula where
Select * from ventas
WHERE clave_producto in ("clz","pzz","qsd");

Select * from ventas
WHERE id_local in (1, 2, 3) AND clave_producto = "pzz";

Select * from ventas
WHERE id_local in (1, 2, 3) AND clave_producto in ("clz","pzz")