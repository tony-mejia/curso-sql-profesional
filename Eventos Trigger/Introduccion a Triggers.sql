/* ============================================================================
   TEMA: Triggers (Disparadores o Gatillos)
   ============================================================================
   Los triggers son el nivel más alto de control sobre la información. 
   Garantizan que las reglas de negocio se cumplan pase lo que pase, 
   incluso si alguien modifica la base de datos manualmente.
============================================================================ */

# TRIGGERS: Un disparador o gatillo es un objeto que esta asociado a una tabla y se activara cuando se ejecute una accion en ella, la accion puede ser; INSERT, UPDATE y DELETE

/*
   APUNTE CLAVE (Los tiempos del Trigger):
   Aunque en tus notas dice que se ejecutan "después", en la práctica 
   puedes programarlos en dos tiempos distintos:
   1. BEFORE (Antes): Atrapa la acción en el aire. Útil para validar o corregir 
      el dato ANTES de que toque la tabla (ej. forzar que un nombre siempre 
      se guarde en mayúsculas).
   2. AFTER (Después): Útil para historiales. Una vez que el dato ya se 
      guardó/borró, el trigger reacciona y anota en otra tabla lo que pasó.
*/
# Se ejecutan despues de un proceso de actualizacion 

/*
   Casos de uso más comunes en el entorno laboral:
   - Tablas de Auditoría (Bitácoras): Guardar "quién borró este registro, a qué 
     hora, y cuál era el dato original".
   - Sincronización (Efecto dominó): Si se hace un INSERT en 'ventas', el 
     trigger dispara un UPDATE automático en 'inventario' restando las unidades.
*/
# Los TRIGGERS  sirven para asegurar la consistencia de la informacion en la base de datos 

/* ============================================================================
   DATOS IMPORTANTES PARA EL FUTURO (La magia de OLD y NEW):
   ----------------------------------------------------------------------------
   Cuando empieces a programarlos, notarás que los Triggers usan dos 
   prefijos exclusivos de SQL para poder comparar datos:
   - OLD: Te permite ver el valor "viejo" (el que estaba ANTES de modificar/borrar).
   - NEW: Te permite ver el valor "nuevo" (el que se está insertando/actualizando).
============================================================================ */