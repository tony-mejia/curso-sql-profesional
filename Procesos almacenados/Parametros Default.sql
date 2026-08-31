/* ============================================================================
   TEMA: Manejo de Errores y Parámetros Opcionales (NULL)
   ============================================================================
   Los Procedimientos Almacenados son estrictos. Si declaras que necesitan 
   ciertos parámetros, debes cumplirlos al momento de invocarlos (CALL).
============================================================================ */

-- ============================================================================
-- 1. ¿QUÉ PASA CUANDO EL PARÁMETRO NO ES CORRECTO? (Omisión de parámetros)
-- ============================================================================
/* 
   A diferencia de otros lenguajes de programación (como Python o JavaScript) 
   donde a veces puedes omitir variables, en SQL la cantidad de argumentos 
   debe ser EXACTA. Si omites los parámetros, el gestor devolverá un error.
*/
# Proceso almacenado con 2 parametros
CALL sp_ventas_producto_categoria();

/* Error presentado
 SQL Error [1318] [42000]: Incorrect number of arguments for PROCEDURE default.sp_ventas_producto_categoria; 
 expected 2, got 0*/


-- ============================================================================
-- 2. EL TRUCO DEL 'IFNULL' PARA FILTROS OPCIONALES (Un parámetro nulo)
-- ============================================================================
/*
   Si queremos que el usuario pueda omitir el producto, debemos obligarlo a 
   enviar un 'NULL', y adaptar nuestro WHERE para que lo interprete.
   
   ¿Cómo funciona la magia de: clave_producto = IFNULL(producto, clave_producto)?
   - Si mandas 'pzz': Se lee como -> clave_producto = 'pzz'. (Filtra las pizzas).
   - Si mandas NULL: Se lee como -> clave_producto = clave_producto. Como esto 
     siempre es verdadero, SQL ignora el filtro y te trae todos los productos.
*/
#Si queremos usar NULL como parametros debemos actualizar el proceso almacenado

/*
 CREATE DEFINER=`root`@`%` PROCEDURE `default`.`sp_ventas_producto_categoria`(producto VARCHAR(3), local_usuario INT(1))
BEGIN
	SELECT *
	FROM ventas
	WHERE clave_producto = IFNULL(producto, clave_producto) AND ID_local = local_usuario;
END*/

-- Llamada enviando NULL en el producto y '1' en el local.
CALL sp_ventas_producto_categoria(NULL, 1);


-- ============================================================================
-- 3. FILTROS 100% OPCIONALES (Ambos parámetros aceptan nulos)
-- ============================================================================
/*
   Aquí aplicamos el mismo truco a ambos parámetros. Si envías (NULL, NULL), 
   la consulta no filtra nada y te devuelve toda la tabla de ventas intacta.
*/
# En ambos parametros

/*
 CREATE DEFINER=`root`@`%` PROCEDURE `default`.`sp_ventas_producto_categoria`(producto VARCHAR(3), local_usuario INT(1))
BEGIN
	SELECT *
	FROM ventas
	WHERE clave_producto = IFNULL(producto, clave_producto) AND ID_local = IFNULL(local_usuario, ID_local);
END*/

CALL sp_ventas_producto_categoria(NULL, NULL);


-- ============================================================================
-- 4. ASIGNACIÓN DE VALORES POR DEFECTO (Comando SET)
-- ============================================================================
/*
   A veces, el negocio dicta que si el usuario no elige nada, debemos forzar 
   una búsqueda específica (ej. "Si no escriben nada, asume que buscan pizza").
   En lugar de desactivar el filtro, usamos un bloque IF para inyectarle un 
   valor ('pzz') a la variable antes de que llegue al SELECT.
*/
# Si queremos valor establecidos

/*
 CREATE DEFINER=`root`@`%` PROCEDURE `default`.`sp_ventas_producto_categoria`(producto VARCHAR(3), local_usuario INT(1))
BEGIN
	IF producto IS NULL THEN
		SET producto ='pzz';
	END IF;
	
	SELECT *
	FROM ventas
	WHERE clave_producto = producto AND ID_local = IFNULL(local_usuario, ID_local);
END*/

-- Al enviar NULL en el producto, el IF de arriba lo convierte internamente a 'pzz'.
CALL sp_ventas_producto_categoria(NULL, NULL);

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - El orden importa: Cuando usas CALL para ejecutar un procedimiento con 
     múltiples parámetros, debes pasarlos en el orden exacto en el que 
     fueron declarados en el CREATE PROCEDURE.
============================================================================ */