#Filtro a rgistros que no tienen datos 
 
SELECT * FROM empleados 
 where domicilio is null;
 
  SELECT * FROM empleados 
 where domicilio is not null;