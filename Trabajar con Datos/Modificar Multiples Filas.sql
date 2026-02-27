#Modificar multiples filas

SELECT * 
FROM ingredientes;

INSERT INTO ingredientes(Ingredientes)
VALUES ("BBQ"),("Jamon"),("J. Serrano")

INSERT INTO ingredientes(Ingredientes,clave_ingrediente,precio_porcion)
VALUES ("champiñon","champ",34),("queso","qso",45)