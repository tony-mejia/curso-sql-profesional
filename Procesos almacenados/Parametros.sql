/* ============================================================================
   TEMA: Procedimientos Almacenados con Parámetros (Variables)
   ============================================================================
   Los parámetros permiten que tu procedimiento sea reutilizable. En lugar 
   de crear un procedimiento para cada producto, creas uno solo que acepta 
   el nombre del producto como una "variable" de entrada.
============================================================================ */

-- ============================================================================
-- 1. PROCEDIMIENTO CON UN PARÁMETRO
-- ============================================================================
/*
   Nota sobre el DEFINER: Cuando exportas un SP desde un programa visual 
   (como MySQL Workbench o DBeaver), automáticamente le agrega 
   `DEFINER='root'@'%'`. Esto solo le dice a la base de datos qué usuario 
   creó el procedimiento y con qué permisos se debe ejecutar. En código 
   manual, con poner CREATE PROCEDURE basta.
   
   Aquí declaras el parámetro `producto` y le asignas el tipo de dato VARCHAR(3).
*/
/*
 CREATE DEFINER=`root`@`%` PROCEDURE `default`.`sp_ventas_producto`(producto VARCHAR(3))
BEGIN
	SELECT *
	FROM ventas
	WHERE clave_producto = producto ;
END*/

-- Ejecuciones dinámicas: Ahora el mismo SP sirve para buscar pizzas o quesadillas.
CALL sp_ventas_producto('pzz');

CALL sp_ventas_producto('qsd');


-- ============================================================================
-- 2. PROCEDIMIENTO CON MÚLTIPLES PARÁMETROS Y LÓGICA INTERNA
-- ============================================================================
/*
   Este segundo procedimiento es de nivel avanzado. Combina tres cosas:
   1. Múltiples parámetros separados por coma.
   2. Modificación de variables internas (IF ... SET).
   3. Filtros opcionales dinámicos (El truco del IFNULL en el WHERE).
*/
/*
 CREATE DEFINER=`root`@`%` PROCEDURE `default`.`sp_ventas_producto_categoria`(producto VARCHAR(3), local_usuario INT(1))
BEGIN
    -- Lógica de control (Valor por defecto):
    -- Si el usuario olvida mandar el producto (manda NULL), el sistema 
    -- automáticamente lo cambia a 'pzz' usando el comando SET.
	IF producto IS NULL THEN
		SET producto ='pzz';
	END IF;
	
	SELECT *
	FROM ventas
	
	-- El truco del filtro opcional:
	-- Si envías un número de local (ej. 1), filtra por ese local.
	-- Pero si envías NULL en el local, el IFNULL devuelve el mismo ID_local 
	-- de la fila actual. Como "ID_local = ID_local" siempre es verdadero, 
	-- SQL simplemente ignora este filtro y te trae TODOS los locales.
	WHERE clave_producto = producto AND ID_local = IFNULL(local_usuario, ID_local);
END*/
	
-- Ejecución con dos parámetros: Busca el producto 'brr' en el local 1.
CALL sp_ventas_producto_categoria('brr',1);

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Tipos de Parámetros: Por defecto, los parámetros son de entrada (IN), es 
     decir, le mandas datos al procedimiento. También existen parámetros de 
     salida (OUT) para que el procedimiento te devuelva un valor calculado.
============================================================================ */