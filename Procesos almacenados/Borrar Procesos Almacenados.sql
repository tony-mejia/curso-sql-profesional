/* ============================================================================
   TEMA: Eliminar Procedimientos Almacenados (DROP PROCEDURE)
   ============================================================================
   Al igual que con las vistas o tablas, habrá momentos en que un 
   procedimiento ya no sea necesario, o que necesites destruirlo para volver 
   a crearlo desde cero con otra lógica.
============================================================================ */

# El comando DROP PROCEDURE se utiliza para eliminar un proceso almacenado

DROP PROCEDURE sp_pizza;

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO:
   ----------------------------------------------------------------------------
   - Seguridad de datos: Al igual que con DROP VIEW, esto SOLO borra el 
     código de la rutina. Los datos reales de tu tabla 'ventas' están 100% 
     a salvo.
     
   - Truco PRO (Prevención de errores): En la vida real, si intentas borrar 
     un procedimiento que alguien más ya borró (o escribes mal el nombre), 
     SQL te lanzará un error fatal que puede detener en seco todo tu trabajo. 
     La práctica estándar en la industria es usar la cláusula IF EXISTS:
     
     DROP PROCEDURE IF EXISTS sp_pizza;
     
     De esta forma, si el procedimiento existe, lo borra; y si no existe, 
     simplemente ignora el comando y el sistema sigue trabajando sin hacer 
     ningún escándalo.
============================================================================ */