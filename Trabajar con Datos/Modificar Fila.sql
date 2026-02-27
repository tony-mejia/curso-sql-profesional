#Modificar la fila de una tabla

SELECT *
FROM ingredientes;

INSERT INTO ingredientes(Ingredientes)
VALUES ("Aceituna");

INSERT INTO ingredientes (Ingredientes, clave_ingrediente)
VALUES ("Salami", "sal");
