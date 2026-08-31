/* ============================================================================
   TEMA: Vistas (Views) y Vistas Actualizables
   ============================================================================
   ¿Qué es una Vista?
   Es una "tabla virtual" que no almacena datos por sí misma, sino que guarda 
   una consulta. Cada vez que llamas a la vista, SQL ejecuta la consulta 
   por debajo y te muestra los datos de la tabla original.
============================================================================ */

-- ============================================================================
-- 1. CREACIÓN DE UNA VISTA
-- ============================================================================
/*
   Casos de uso principales en la vida real:
   1. Seguridad: Le das acceso a un empleado solo a esta vista (ej. ventas > 800) 
      y le restringes el acceso a la tabla original 'ventas'.
   2. Simplicidad: Guardas un script gigante de 50 líneas con muchos JOINs, 
      para que tus compañeros solo tengan que escribir "SELECT * FROM vista;".
*/
CREATE VIEW ventas_mayores_800 AS
SELECT *
FROM ventas v 
WHERE venta > 800;


-- ============================================================================
-- 2. EL PELIGRO DE LAS VISTAS ACTUALIZABLES (Updatable Views)
-- ============================================================================
/*
   Tu apunte es 100% correcto. Como la vista es solo una "ventana" directa a 
   la tabla original, cualquier acción de modificación (DELETE, UPDATE o INSERT) 
   atravesará la ventana y afectará a los datos reales de la base de datos.
*/
# Si borramos algo de las vistas se puede borrar informacion de las tablas originales, por ejemplo:

/* DELETE FROM ventas_mayores_800 s
-WHERE s.venta > 1000; */


/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Vistas de "Solo Lectura": No todas las vistas permiten borrar o actualizar 
     datos. Si tu vista contiene un GROUP BY, DISTINCT, JOINs complejos o 
     funciones como SUM/AVG, el motor de SQL la bloquea y no te dejará hacer 
     un DELETE (te marcará error).
   - Para eliminar la "ventana": Si lo que quieres es borrar la vista como tal 
     (borrar la consulta guardada, sin afectar los datos reales), debes usar:
     DROP VIEW ventas_mayores_800;
============================================================================ */