/* ============================================================================
   TEMA: Sincronizar el Modelo de Datos
   ============================================================================
   Objetivo: Entender qué hace el asistente de sincronización de Workbench:
   compara el modelo con la base y aplica las diferencias para que las tablas
   coincidan.
============================================================================ */

#En MySQL Workbench al modificar el modelo fisico hay que darle a la opcion Sicrononizar Modelo para que las tablas reflejen los cambios

/*
   Synchronize Model no copia la tabla entera: compara. Toma el modelo y la base
   conectada, calcula la diferencia y arma las sentencias que hacen falta para
   que coincidan. Antes de aplicarlas, el asistente muestra ese diff y deja
   revisarlo.

   Eso convierte la sincronización en una operación de esquema con datos dentro:
   puede agregar o quitar columnas e índices, y también puede tocar llaves. Por
   eso el script generado se revisa antes de ejecutarlo, igual que el de Forward
   Engineer.

   El asistente también permite la dirección contraria, traer hacia el modelo lo
   que hay en la base. Es la misma comparación; lo que cambia es de qué lado se
   aplica.
*/

/* ============================================================================
   SINCRONIZAR MODELO Y BASE: EL DIFF QUE NO SE CORRE A CIEGAS
   ----------------------------------------------------------------------------
   - La sincronización es un diff, y un diff puede proponer borrados: si algo
     desapareció del modelo, el script puede traer un DROP COLUMN. Se revisa
     antes de aplicar, con la misma calma que el DDL de Forward Engineer.
   - Corre con datos dentro: el asistente conecta a la base real y ejecuta los
     cambios ahí. Con datos en producción se prueba primero sobre una copia.
   - La base es la fuente de verdad, no el modelo. Si alguien cambió el esquema
     con ALTER TABLE, sincronizar desde un modelo viejo puede revertir ese
     cambio.
   - Guardar el script que genera el asistente es útil, pero el modelo (.mwb) no
     es un artefacto que se pueda revisar en un diff de texto. Para el historial
     del esquema conviene una secuencia de scripts.

   ----------------------------------------------------------------------------
   NIVEL PRO: CAMBIOS DE ESQUEMA VERSIONADOS (lo que el curso no cubre)
   ----------------------------------------------------------------------------
   El diff de la GUI sirve para explorar, pero no es repetible ni se puede correr
   solo en otro entorno. En producción los cambios de esquema se versionan como
   scripts numerados y los aplica una herramienta de migración (Flyway,
   Liquibase o un directorio ordenado con un runner propio):
   -- Estructura ilustrativa (un archivo por cambio, aplicado en orden):
   -- V1__<cambio_inicial>.sql
   -- V2__<cambio_siguiente>.sql
   Así el mismo cambio corre igual en desarrollo, pruebas y producción, y queda
   registrado qué se aplicó y en qué orden.
============================================================================ */
