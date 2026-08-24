/* ============================================================================
   TEMA: Manejo de Valores Nulos (IFNULL y COALESCE)
   ============================================================================
   Ambas funciones nos ayudan a lidiar con los NULLs (datos faltantes o vacíos).
   
   APUNTE CLAVE: Ninguna de estas funciones reemplaza los valores en la 
   tabla real de la base de datos. Solo "maquillan" el resultado al momento 
   de hacer la consulta (SELECT).
============================================================================ */

-- ============================================================================
-- 1. EJEMPLO CON IFNULL
-- ============================================================================
/*
   ¿Qué hace? 
   Devuelve un valor especificado si la expresión original es NULL.
   Sintaxis: IFNULL(columna_a_revisar, valor_de_reemplazo)
   
   Nota: Solo acepta EXACTAMENTE dos parámetros.
*/
SELECT *
FROM empleados;

SELECT 
    nombre,
    IFNULL(ID_Gerente, "Gerente") AS Nivel_Gerencial
FROM empleados;


-- ============================================================================
-- 2. EJEMPLO CON COALESCE
-- ============================================================================
/*
   ¿Qué hace?
   Recorre una lista de opciones (columnas o textos) y devuelve el PRIMER 
   valor que NO sea nulo.
   
   En tu ejemplo:
   1. ¿ID_Gerente tiene dato? Si sí, lo muestra y termina. Si es NULL, pasa al 2.
   2. ¿Nombre tiene dato? Si sí, lo muestra y termina. Si es NULL, pasa al 3.
   3. Muestra el texto "Gerente" como comodín final.
*/
SELECT 
    nombre,
    COALESCE(ID_Gerente, Nombre, "Gerente") AS gernete_nuevo
FROM empleados;


-- ============================================================================
-- 3. DIFERENCIA ENTRE IFNULL Y COALESCE
-- ============================================================================
/*
   - IFNULL: Checa si UN valor es nulo y lo reemplaza por un valor que yo le diga. 
     (Es binario: opción A u opción B).
     
   - COALESCE: Checa si un valor es nulo y lo reemplaza por un valor de OTRA 
     columna; y si esa también es nula, lo reemplaza por un valor que yo le diga. 
     (Es una cadena de opciones: opción A, si no B, si no C, si no D...).
*/


/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - El estándar ANSI (La alternativa PRO): IFNULL es exclusivo de MySQL y 
     SQLite (en SQL Server se llama ISNULL). Sin embargo, COALESCE es el 
     estándar universal. Al igual que con el CASE, si te acostumbras a usar 
     COALESCE, tu código funcionará en cualquier gestor de bases de datos.
============================================================================ */