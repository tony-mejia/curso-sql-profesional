/* ============================================================================
   TEMA: Procedimientos Almacenados (Stored Procedures)
   ============================================================================
   Un Stored Procedure (SP) es un conjunto de instrucciones SQL precompiladas 
   y guardadas en el servidor. 
   
   Buena Práctica: Notarás que el nombre empieza con "sp_". Esto es un 
   estándar universal de la industria para identificar rápidamente que se 
   trata de un Stored Procedure y no de una tabla o vista.
============================================================================ */

-- ============================================================================
-- 1. LA CONSULTA BASE (Fase de Prueba)
-- ============================================================================
SELECT *
FROM ventas v 
WHERE v.clave_producto = "pzz";


-- ============================================================================
-- 2. CREACIÓN DEL PROCEDIMIENTO ALMACENADO
-- ============================================================================
/* 
   El problema del punto y coma (;): 
   Por defecto, MySQL ejecuta una instrucción en cuanto ve un ';'. 
   Pero un procedimiento almacenado tiene su propio código por dentro (que 
   también usa ';'). Si no cambiamos el delimitador temporalmente, MySQL 
   cortaría la creación del procedimiento por la mitad y marcaría error.
*/
# Para crear un proceso almacenado de la anterior consulta se usa CREATE PROCEDURE

# Clausula DELIMITER Utilizado para definir temporalmente el delimitador del codigo que permite ejecutar por separado las consultas o declarciones
-- (Le decimos a SQL: "A partir de ahora, mi símbolo para ejecutar es //")
DELIMITER //

CREATE PROCEDURE sp_pizza()
# BEGIN...END Utilizado para describir sentencias compuestas, que pueden aparecer dentro de un proceso almacenado
-- (Todo lo que esté entre BEGIN y END es el "cuerpo" de tu programa)
BEGIN
	SELECT *
	FROM ventas v 
	WHERE v.clave_producto = 'pzz';
END //

-- Regresamos el delimitador a su estado normal (el punto y coma)
DELIMITER ;


-- ============================================================================
-- 3. EJECUCIÓN DEL PROCEDIMIENTO
-- ============================================================================
/*
   A diferencia de las vistas (que se llaman con SELECT), los procedimientos 
   son rutinas ejecutables, por lo que se deben "llamar" o "invocar".
*/
# CLausula CALL Invoca un proceso almacenado que se definio previamente con CREATE PROCEDURE

CALL sp_pizza();


-- ============================================================================
-- 4. DIFERENCIAS FUNDAMENTALES (VISTAS VS STORED PROCEDURES)
-- ============================================================================
/* ¿Cual es la diferencia fundamental entre stored procedures y vista?
Las vistas son mas limitadas, solo te sirven para guardar una consulta 
Los procesos almacenados te sirven para guardar una consulta, para llamar una consulta, 
para actualizar una consulta, para actualizar tablas, para meter if, para meterle agregaciones, para meterle case) */

/* ============================================================================
   APUNTE PRO PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - La verdadera magia de los SP: Este primer ejemplo es estático (siempre 
     busca 'pzz'). Pero el poder real de los procedimientos es que aceptan 
     VARIABLES (Parámetros). Podrías crear un `sp_buscar_producto(clave)` 
     y llamarlo así: CALL sp_buscar_producto('hamb'); o CALL sp_buscar_producto('soda'); 
     haciendo que el mismo código sirva para miles de escenarios.
============================================================================ */