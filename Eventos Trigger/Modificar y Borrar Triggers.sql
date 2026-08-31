/* ============================================================================
   TEMA: Gestión de Triggers (Listar y Eliminar)
   ============================================================================
   Al ser objetos automatizados y silenciosos, es fácil olvidar que existen.
   Saber cómo listarlos y borrarlos es vital para tener el control total 
   de lo que ocurre en tu base de datos.
============================================================================ */

# Como trabajar con los triggers dentro del GUI y con Codigo

/* 
   APUNTE SOBRE EL GUI (Gestores visuales como DBeaver / Workbench):
   A diferencia de las Vistas o Procedimientos que tienen su propia carpeta 
   principal, los Triggers suelen estar "escondidos" adentro de la carpeta 
   de la TABLA específica a la que pertenecen.
*/
# Se pueden ver dentro de las carpetas de las tablas pero tambien


-- ============================================================================
-- 1. VER LOS TRIGGERS EXISTENTES
-- ============================================================================
# SHOW TRIGGERS: Enlista los triggers definidos actualmente para las tablas

/* 
   Esta consulta te devolverá una tabla con información muy valiosa:
   - Trigger: El nombre del disparador.
   - Event: Qué acción lo detona (INSERT, UPDATE, DELETE).
   - Table: A qué tabla está vigilando.
   - Timing: Si se dispara ANTES (BEFORE) o DESPUÉS (AFTER).
*/
SHOW TRIGGERS;


-- ============================================================================
-- 2. ELIMINAR UN TRIGGER
-- ============================================================================
# ¿como borrar triggers? 
# DROP TRIGGER: Elimina el TRIGGER definido. Requiere privilegios de administrador 

/*
   Truco PRO: Igual que vimos en los Procedimientos Almacenados, la mejor 
   práctica para scripts automatizados es usar IF EXISTS para evitar que 
   tu código se detenga por un error si el trigger ya no existe:
   DROP TRIGGER IF EXISTS pago_after_insert;
*/
DROP TRIGGER pago_after_insert;

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - La Modificación no existe: En MySQL NO existe el comando 
     "CREATE OR REPLACE TRIGGER". Si te equivocaste en la lógica de un Trigger 
     y necesitas modificarlo, estás obligado a hacerle DROP TRIGGER primero, 
     y luego volver a correr tu CREATE TRIGGER desde cero.
   - Triggers Huérfanos: Si borras la tabla principal (DROP TABLE), el motor 
     eliminará automáticamente los Triggers asociados a ella.
============================================================================ */