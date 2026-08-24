/* ============================================================================
   TEMA: Funciones de Control de Flujo (Condicional IF)
   ============================================================================
   La función condicional sirve para tomar decisiones fila por fila.
   Evalúa una condición y devuelve un valor si es verdadera, y otro si es falsa.
============================================================================ */

-- ============================================================================
-- 1. APLICACIÓN DE LA FUNCIÓN SI (IF)
-- ============================================================================
/*
   Sintaxis: IF(condición, valor_si_verdadero, valor_si_falso)
   
   En este caso: 
   - Condición: ¿La venta es mayor a 1200?
   - Si es Verdad: Escribe "bono".
   - Si es Falso: Escribe "-".
*/
SELECT 
    venta,
    v.venta_empleado,
    IF(venta > 1200, "bono", "-") AS bono
FROM ventas v;

/* ============================================================================
   APUNTE DE REPASO:
   En este ejemplo, el cálculo con el IF solo existe en la visualización de 
   la consulta; NO se modifica la tabla original en la base de datos. 
   La columna 'bono' es 100% virtual y temporal.
============================================================================ */


/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Limitación: La función IF() es nativa de MySQL/MariaDB. Si intentas 
     usarla en SQL Server o PostgreSQL, te marcará error.
   - El estándar ANSI (La alternativa PRO): En el mundo profesional, 
     especialmente si hay múltiples condiciones (ej. "bono alto", "bono bajo", 
     "sin bono"), se utiliza la estructura CASE WHEN, la cual funciona en 
     absolutamente todos los gestores de bases de datos.
============================================================================ */