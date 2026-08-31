/* ============================================================================
   TEMA: Gestión de Vistas (DROP y CREATE OR REPLACE)
   ============================================================================
   Las vistas no son estáticas. Conforme el negocio cambia, vas a necesitar 
   eliminarlas o modificar sus filtros y columnas.
============================================================================ */

-- ============================================================================
-- 1. ELIMINAR UNA VISTA (DROP VIEW)
-- ============================================================================
/*
   ¿Qué hace realmente?
   Elimina la "receta" guardada en la base de datos. 
   Ojo: A diferencia de lo que vimos con el DELETE, usar DROP VIEW es 
   100% seguro para tu información. Solo destruye la "ventana virtual", 
   pero los datos reales en las tablas 'local', 'ventas' y 'empleados' 
   quedan completamente intactos.
*/
# Comando DROOP VIEW, elimina una vista por completo

DROP VIEW ventas_empleados;


-- ============================================================================
-- 2. MODIFICAR UNA VISTA (CREATE OR REPLACE VIEW)
-- ============================================================================
/*
   ¿Por qué no usar simplemente DROP y luego CREATE de nuevo?
   En el mundo real, a las vistas se les asignan permisos (ej. "el usuario 
   de Recursos Humanos puede leer esta vista"). Si usas DROP, borras la vista 
   y borras todos esos permisos. 
   
   Al usar CREATE OR REPLACE, la base de datos actualiza el código interno 
   de la consulta, pero mantiene intactos los permisos y configuraciones de 
   seguridad. ¡Es la forma profesional de hacerlo!
*/

# Para modificar una vista. CREATE OR REPLACE VIEW

# Vista original

CREATE VIEW ventas_empleados AS
SELECT 
	l.letra_zona,
	l.telefono,
	v.venta,
	v.venta_empleado,
	e.nombre
FROM local l
LEFT JOIN ventas v
	ON l.ID_local = v.ID_local
LEFT JOIN empleados e
	ON v.venta_empleado = e.ID_empleado;


# Actualizar esta vista (Agregando un filtro WHERE)

/*
   En este caso, actualizamos la vista para que ahora solo muestre las 
   ventas "fuertes" (mayores a 1000). Quien consulte 'ventas_empleados' 
   a partir de ahora, ya verá la información filtrada por defecto.
*/
CREATE OR REPLACE VIEW ventas_empleados AS
SELECT 
	l.letra_zona,
	l.telefono,
	v.venta,
	v.venta_empleado,
	e.nombre
FROM local l
LEFT JOIN ventas v
	ON l.ID_local = v.ID_local
LEFT JOIN empleados e
	ON v.venta_empleado = e.ID_empleado
WHERE venta > 1000;

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - CREATE OR REPLACE es compatible con MySQL, MariaDB, PostgreSQL y Oracle. 
     Sin embargo, si alguna vez trabajas con SQL Server, el comando cambia a: 
     ALTER VIEW nombre_vista AS ...
============================================================================ */