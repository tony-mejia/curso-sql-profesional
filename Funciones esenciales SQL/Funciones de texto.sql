/* ============================================================================
   TEMA: Funciones de Texto (Cadenas de Caracteres / Strings)
   ============================================================================
   Estas funciones se utilizan para limpiar, formatear, extraer y unir 
   texto dentro de la base de datos. Son fundamentales para la limpieza de datos.
============================================================================ */

-- ============================================================================
-- 1. FUNCIÓN LENGTH (Longitud)
-- ============================================================================
/* 
   Devuelve la longitud (cantidad de caracteres) de la cadena de texto. 
   ¡Ojo! También cuenta los espacios en blanco, tanto en medio como al final.
*/
SELECT LENGTH("ejemplo ");


-- ============================================================================
-- 2. FUNCIÓN UPPER (Mayúsculas)
-- ============================================================================
/* 
   Convierte todo el texto a mayúsculas. Muy útil para estandarizar 
   búsquedas o reportes (ej. obligar a que todos los RFC se vean en mayúscula).
*/
SELECT UPPER("hola");


-- ============================================================================
-- 3. FUNCIÓN LOWER (Minúsculas)
-- ============================================================================
/* 
   Convierte todo el texto a minúsculas. Ideal para estandarizar correos 
   electrónicos en la base de datos.
*/
SELECT LOWER("HOLA");


-- ============================================================================
-- 4. FUNCIÓN LTRIM (Left Trim - Recortar Izquierda)
-- ============================================================================
/* 
   Elimina únicamente los espacios en blanco que estén al INICIO (izquierda) 
   de una cadena de caracteres.
*/
SELECT LTRIM("   ejemplo");


-- ============================================================================
-- 5. FUNCIÓN RTRIM (Right Trim - Recortar Derecha)
-- ============================================================================
/* 
   Elimina únicamente los espacios en blanco que estén al FINAL (derecha) 
   de una cadena de caracteres. 
   (Nota: En tu ejemplo pusiste un '0' al final, por lo que RTRIM no borrará 
   los espacios que están antes del cero, solo borraría espacios si estuvieran 
   al extremo derecho absoluto).
*/
SELECT RTRIM("ejemplo    0");


-- ============================================================================
-- 6. FUNCIÓN LEFT (Izquierda)
-- ============================================================================
/* 
   Extrae la cantidad de caracteres indicados en el segundo parámetro, 
   empezando a contar desde el extremo izquierdo de la cadena.
*/
SELECT LEFT("ejemplo", 3);


-- ============================================================================
-- 7. FUNCIÓN RIGHT (Derecha)
-- ============================================================================
/* 
   Extrae la cantidad de caracteres indicados en el segundo parámetro, 
   empezando a contar desde el extremo derecho (el final) hacia atrás.
*/
SELECT RIGHT("ejemplo", 3);


-- ============================================================================
-- 8. FUNCIÓN TRIM (Recortar Ambos Lados)
-- ============================================================================
/* 
   Elimina los espacios en blanco tanto iniciales como finales de una cadena.
   Esta es la función de limpieza por excelencia. Siempre úsala cuando 
   importes datos de Excel. (Nota: No elimina los espacios ENTRE palabras).
*/
SELECT TRIM("    hola    ");


-- ============================================================================
-- 9. FUNCIÓN SUBSTRING (Subcadena / Extraer del medio)
-- ============================================================================
/* 
   Extrae una parte del texto empezando en cualquier posición.
   Parámetros: (texto, posición_inicial, cantidad_de_caracteres_a_extraer)
   En tu ejemplo: Empieza en el caracter 2 ('j') y extrae 4 caracteres ('jemp').
*/
SELECT SUBSTRING("ejemplo", 2, 4);


-- ============================================================================
-- 10. FUNCIÓN LOCATE (Localizar)
-- ============================================================================
/* 
   Busca un caracter o palabra y devuelve el NÚMERO de la posición donde 
   lo encontró por primera vez. Si no lo encuentra, devuelve 0.
   Parámetros: (lo_que_busco, en_qué_texto)
*/
SELECT LOCATE("j", "ejemplo");


-- ============================================================================
-- 11. FUNCIÓN REPLACE (Reemplazar)
-- ============================================================================
/* 
   Busca una cadena de caracteres específica y la cambia por otra nueva 
   en todo el texto.
   Parámetros: (texto_original, lo_que_quiero_quitar, lo_que_quiero_poner)
*/
SELECT REPLACE("ejemplo", "jemplo", "xample");


-- ============================================================================
-- 12. FUNCIÓN CONCAT (Concatenar)
-- ============================================================================
/* 
   Une (pega) dos o más fragmentos de texto en una sola cadena.
   Nota: Siempre recuerda agregar espacios (" ") entre los campos, de lo 
   contrario todo quedará pegado.
*/
SELECT CONCAT("ejemplo", " ", "SQL");

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Concatenar con NULLs: En muchos motores SQL, si usas CONCAT y tan solo 
     UNO de los valores es NULL, el resultado final de toda la cadena será NULL. 
     (Ej: CONCAT('Hola ', NULL) = NULL).
   - Equivalencias: En SQL Server la función LENGTH se llama LEN(). 
     En PostgreSQL puedes usar el símbolo `||` en lugar de la palabra CONCAT 
     (ej. 'ejemplo' || ' ' || 'SQL').
============================================================================ */




