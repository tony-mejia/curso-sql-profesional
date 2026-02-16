#Para estos ejercicios practicos se utilizo la BD_Northwind
USE northwind

#Ejercicio 1 Lista todos los productos activos (no descontinuados) cuyo list_price sea mayor a 25.

SELECT product_name, list_price FROM products 
WHERE discontinued = 0 AND list_price > 25;

#Ejercicio 2 Muestra los productos cuyo nombre contenga la palabra "chocolate", sin importar mayúsculas o minúsculas. 

SELECT product_name FROM products
WHERE product_name LIKE ("%chocolate%"); 

#Ejercicio 3 Lista los productos cuyo precio esté entre 20 y 100, y ordena el resultado por precio descendente.

SELECT product_name, list_price FROM products
WHERE list_price BETWEEN 20 and 100
ORDER BY list_price DESC;

#Ejercicio 4 Lista todos los productos cuya categoría sea "Beverages", "Condiments" o "Candy".

SELECT product_name, category FROM products
WHERE category IN ("Beverages", "Condiments", "Candy");

#Ejercicio 5 Muestra los productos con standard_cost menor a 10 o que estén descontinuados.

SELECT product_name, standard_cost, discontinued FROM products
WHERE standard_cost <10 or discontinued = 1;

#Ejercicio 6 Encuentra productos que no tengan descripción registrada.

SELECT product_name FROM products
WHERE description IS NULL;

#Ejercicio 7 Obtén los 5 productos más caros (list_price) que estén activos.

SELECT product_name, list_price FROM products
WHERE discontinued = 0
ORDER BY List_price DESC 
LIMIT 5;

#Ejercicio 8 Muestra los productos cuyo nombre termina en “Tea”.

SELECT product_name FROM products
WHERE product_name LIKE ("%Tea");

#Ejercicio 9 Lista los productos con categoría distinta de "Oil", "Candy" y "Cereal" y con list_price mayor a 15.

SELECT product_name, category, list_price FROM products
WHERE NOT category IN ("Oil", "Candy", "Cereal") AND list_price >15;

#Ejercicio 10 Muestra los productos activos cuyo product_name solo contenga letras y espacios (sin números). Usa una expresión regular.

SELECT product_name FROM products
WHERE discontinued=0 AND product_name REGEXP "^[A-Za-z ]+$";
