/* ============================================================================
   TEMA: Funciones Numéricas (Escalares)
   ============================================================================
   Utilizadas para realizar operaciones matemáticas con números.
   Como resultado, siempre obtenemos valores numéricos.
   
   Nota de sintaxis: En muchos gestores (como MySQL o SQL Server), podemos 
   ejecutar funciones usando solo SELECT sin llamar a ninguna tabla. 
   Esto es útil para probar cálculos rápidos.
============================================================================ */

-- ============================================================================
-- 1. FUNCIÓN ROUND (Redondeo matemático)
-- ============================================================================
/* 
   Retorna un número redondeado con la cantidad de decimales indicada.
   Regla clásica: Si el siguiente decimal es 5 o mayor, sube; si es menor a 5, se queda igual.
   Ejemplo: 2.4575 a 2 decimales -> El tercer decimal es 7, así que sube a 2.46.
*/
SELECT ROUND(2.4575, 2);


-- ============================================================================
-- 2. FUNCIÓN TRUNCATE (Corte directo)
-- ============================================================================
/* 
   Corta el número en la posición decimal indicada. Quita los decimales que 
   sobren, PERO NO REDONDEA. Es un "tijeretazo" literal al número.
   Ejemplo: 2.4575 a 3 decimales -> Queda 2.457 (ignora el 5 final).
*/
SELECT TRUNCATE(2.4575, 3);


-- ============================================================================
-- 3. FUNCIÓN CEILING (Redondeo hacia arriba / Techo)
-- ============================================================================
/* 
   Devuelve el valor entero más pequeño que es mayor o igual al número indicado. 
   Sin importar los decimales, siempre fuerza el redondeo hacia arriba al 
   siguiente número entero.
   Ejemplo: 2.1 ya se convierte en 3.
*/
SELECT CEILING(2.12341230);


-- ============================================================================
-- 4. FUNCIÓN FLOOR (Redondeo hacia abajo / Piso)
-- ============================================================================
/* 
   Devuelve el valor entero más grande que es menor o igual al número indicado. 
   Fuerza el redondeo hacia abajo, eliminando los decimales.
   Ejemplo: 2.89 no sube a 3, baja al entero base, que es 2.
*/
SELECT FLOOR(2.897969);


-- ============================================================================
-- 5. FUNCIÓN ABS (Valor Absoluto)
-- ============================================================================
/* 
   Devuelve el valor absoluto del número. El valor absoluto siempre es positivo.
   Muy útil cuando haces restas (ej. Ventas - Gastos) y solo quieres saber 
   la magnitud de la diferencia, sin importar si es pérdida o ganancia.
*/
SELECT ABS(-5);


-- ============================================================================
-- 6. FUNCIÓN RAND (Aleatoriedad)
-- ============================================================================
/* 
   Devuelve un número decimal aleatorio entre 0 y 1 (ej. 0.34567).
*/
SELECT RAND();

/* 
   Combo Pro: Combinar funciones.
   Aquí generas un número entre 0 y 1, lo multiplicas por 100 (para que sea 
   de 0 a 99.99), y luego le pasas TRUNCATE con 0 decimales para quedarte 
   solo con el entero. ¡Acabas de crear un generador de enteros aleatorios!
*/
SELECT TRUNCATE(RAND()*100,0);

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Compatibilidad: En Oracle, no puedes hacer un SELECT "al vacío". Para 
     probar estas funciones tendrías que agregar "FROM DUAL" al final 
     (ej. SELECT ABS(-5) FROM DUAL;).
   - TRUNCATE vs TRUNC: En SQL Server y PostgreSQL la función suele llamarse 
     TRUNC, mientras que en MySQL es TRUNCATE. Hacen lo mismo.
============================================================================ */
