/* ============================================================================
   TEMA: Vistas (Views) con Múltiples Tablas (JOINs)
   ============================================================================
   Tu definición inicial es perfecta:
   "Una vista consta de filas y columnas provenientes de una consulta, esta 
   no pertenece a la base de datos (no ocupa espacio en disco para los datos) 
   y es utilizada únicamente para fines prácticos."
============================================================================ */

# Vistas o tablas virtuales
# Una vista consta de filas y columanas provenientes de una consulta, esta no pertenece a la base de datos y es utilizada unicamente para fines practicos

-- ============================================================================
-- 1. LA CONSULTA BASE (Fase de Prueba)
-- ============================================================================
/*
   Antes de crear una vista, SIEMPRE es una buena práctica armar la consulta
   y probarla en crudo (como lo hiciste aquí). Esto asegura que los LEFT JOIN 
   traigan exactamente los datos que esperas sin errores de sintaxis.
*/
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

-- ============================================================================
-- 2. CREACIÓN DE LA VISTA
-- ============================================================================
/*
   El gran poder de las Vistas: "Ocultar la complejidad".
   A partir de hoy, si alguien en tu área de administración necesita un reporte 
   con los datos del local, las ventas y los empleados, ya no tiene que 
   aprender a escribir LEFT JOINs. Tú ya hiciste el trabajo pesado.
*/
# Para convertir en vista esta consulta debemos utilizar CREATE VIEW

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

-- ============================================================================
-- 3. CÓMO CONSUMIR LA VISTA
-- ============================================================================
/*
   Como bien apuntas, los gestores gráficos (como DBeaver, MySQL Workbench) 
   te la mostrarán en la carpeta 'Views'.
   Lo mejor es que, a nivel de código, la tratas exactamente igual que a 
   una tabla normal. ¡Le puedes aplicar un WHERE, GROUP BY o ORDER BY!
*/
# La puedo ver desde la carpeta Views en la carpeta de la base de datos
# O llamarla con select

SELECT *
FROM ventas_empleados ve;


/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Datos siempre actualizados en tiempo real: Como la vista solo guarda la 
     "receta" (el SELECT), si mañana un empleado registra una nueva venta, 
     al hacer SELECT a tu vista, esa venta aparecerá automáticamente. No tienes 
     que actualizar nada manual.
   - Truco PRO (Modificar Vistas): Si en el futuro quieres agregar una 
     columna extra a tu vista, no necesitas borrarla con DROP. Puedes usar:
     CREATE OR REPLACE VIEW ventas_empleados AS ...
============================================================================ */