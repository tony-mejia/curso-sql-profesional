/* ============================================================================
   TEMA: Funciones de Fecha y Hora (Date / Time)
   ============================================================================
   Se utilizan para obtener, manipular y extraer partes específicas de un 
   dato de tipo fecha u hora. Son esenciales para el análisis de series de tiempo.
============================================================================ */

-- ============================================================================
-- 1. OBTENER FECHA Y HORA ACTUAL
-- ============================================================================

/* 
   Función NOW: Devuelve la hora y fecha actual del servidor.
   Formato estándar: 'YYYY-MM-DD HH:MM:SS' (Timestamp).
   Uso típico: Guardar exactamente en qué momento se hizo una venta o registro.
*/
SELECT NOW();


/* 
   Función CURDATE (Current Date): Devuelve SOLAMENTE la fecha actual.
   Formato estándar: 'YYYY-MM-DD'.
   Uso típico: Filtrar las ventas que ocurrieron "el día de hoy", sin importar la hora.
*/
SELECT CURDATE();


/* 
   Función CURTIME (Current Time): Devuelve SOLAMENTE la hora actual.
   Formato estándar: 'HH:MM:SS'.
*/
SELECT CURTIME();


-- ============================================================================
-- 2. EXTRAER COMPONENTES NUMÉRICOS
-- ============================================================================

-- Función YEAR: Extrae el año (ej. 2026)
SELECT YEAR(NOW());

-- Función MONTH: Extrae el número del mes (1 al 12)
SELECT MONTH(NOW());

-- Función DAY: Extrae el número del día (1 al 31)
SELECT DAY(NOW());

-- Función HOUR: Extrae la hora en formato 24h (0 a 23)
SELECT HOUR(NOW());

-- Función MINUTE: Extrae el minuto exacto (0 a 59)
SELECT MINUTE(NOW());

-- Función SECOND: Extrae el segundo exacto (0 a 59)
SELECT SECOND(NOW());


-- ============================================================================
-- 3. EXTRAER NOMBRES (Útil para reportes legibles)
-- ============================================================================

/* 
   Función DAYNAME: Devuelve el nombre del día de la semana.
   Nota: Por defecto en la mayoría de bases de datos, lo devuelve en inglés 
   (Monday, Tuesday...), a menos que el servidor esté configurado en español.
*/
SELECT DAYNAME(NOW());


/* 
   Función MONTHNAME: Devuelve el nombre del mes del año.
   Al igual que DAYNAME, el idioma depende de la configuración del servidor 
   (January, February...).
*/
SELECT MONTHNAME(NOW());


-- ============================================================================
-- 4. FUNCIÓN EXTRACT (El estándar de la industria)
-- ============================================================================
/* 
   EXTRACT hace lo mismo que las funciones de arriba (YEAR, MONTH, DAY), pero 
   es el estándar oficial de SQL (ANSI). Si algún día migras de MySQL a 
   PostgreSQL u Oracle, EXTRACT casi siempre va a funcionar sin tener que 
   reescribir tu código.
   Sintaxis: EXTRACT( COMPONENTE FROM fecha )
*/
SELECT EXTRACT(DAY FROM NOW());
SELECT EXTRACT(MONTH FROM NOW());
SELECT EXTRACT(YEAR FROM NOW());


/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Formato Universal: En SQL, las fechas SIEMPRE se escriben de mayor a menor: 
     Año-Mes-Día ('YYYY-MM-DD'). Si intentas meter 'DD-MM-YYYY' te dará error.
   - Husos Horarios (Timezones): NOW() devuelve la hora del servidor donde 
     está instalada la base de datos. Si tu servidor está alojado en otro país, 
     NOW() te dará la hora de allá, no la de tu computadora local.
============================================================================ */














