/* ============================================================================
   TEMA: Eventos Programados (Event Scheduler / CRON Jobs)
   ============================================================================
   Hay un tigger especial que se llama evento.
   Un Evento es un bloque de codigo que se ejecuta cada cierto tiempo.
   
   ¿Para que ejecutar algo periodicamente? 
   Se usan para hacer mantenimientos, borrar basura, cosas que se ejecutan 
   cada noche, o cierres contables de fin de mes.
============================================================================ */


-- ============================================================================
-- 1. VERIFICAR QUE EL MOTOR DE EVENTOS ESTÉ ENCENDIDO
-- ============================================================================
/*
   ¡Regla de oro! MySQL tiene un "switch" maestro para los eventos. 
   Si la variable 'event_scheduler' está en OFF, puedes crear mil eventos 
   pero ninguno se va a ejecutar. Con este comando verificas su estado.
*/
SHOW VARIABLES LIKE 'event%';


-- ============================================================================
-- 2. CREACIÓN DEL EVENTO
-- ============================================================================
# Ejmplo practico de auditoria de pagos donde cada año nos vamos a quedar solo con los datos de los ultimos 365 dias, los demas datos se borran

DELIMITER //

-- Recomendacion que la primer palabra hable sobre la periodicidad del evento (Excelente práctica)
CREATE EVENT anual_borrar_filas_auditoria

-- ON SCHEDULE: Define la frecuencia y el rango de vida del evento
ON SCHEDULE
    -- Se ejecutará cada 1 año, empezando en la Navidad de 2023 y jubilándose en 2028.
    -- Nota: STARTS y ENDS son opcionales. Si los omites, empieza hoy y dura para siempre.
	EVERY 1 YEAR STARTS '2023-12-25' ENDS '2028-12-25'
	
-- DO: Lo que va a hacer cuando llegue la fecha
DO BEGIN
	DELETE FROM auditoria_pagos
    -- La matemática de fechas en SQL: Toma la fecha de hoy y réstale 1 año entero. 
    -- Todo lo que sea más viejo que eso, se borra.
	WHERE fecha < NOW() - INTERVAL 1 YEAR;

END //

DELIMITER ;


-- ============================================================================
-- 3. GESTIÓN DE EVENTOS
-- ============================================================================
#Para ver que y cuantos eventos existen

/*
   Este comando te mostrará todos los eventos activos en tu base de datos, 
   su periodicidad, y algo muy importante: la columna 'Status' (que te dice 
   si el evento está ENABLED o DISABLED).
*/
SHOW EVENTS;

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Encender el motor: Si el paso 1 te sale en "OFF", puedes encenderlo 
     (si tienes permisos de root) ejecutando: 
     SET GLOBAL event_scheduler = ON;
   - Modificar un evento: Al igual que las vistas, puedes alterar un evento 
     existente sin borrarlo usando el comando ALTER EVENT. Por ejemplo, para 
     apagarlo temporalmente:
     ALTER EVENT anual_borrar_filas_auditoria DISABLE;
============================================================================ */