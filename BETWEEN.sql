SELECT * FROM ventas
WHERE venta >= 500 and venta < 1000;

#Bwtween datos en el rango seleccionado, pueden ser fechas, texto o numeros. Between es incluyente.
SELECT * FROM ventas
WHERE venta BETWEEN 500 AND 1000;