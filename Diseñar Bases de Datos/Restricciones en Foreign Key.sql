/* ============================================================================
   TEMA: Restricciones en Foreign Key (ON UPDATE / ON DELETE)
   ============================================================================
   Una clave foránea puede reaccionar de varias maneras cuando se actualiza o
   se elimina la fila referenciada; acá están las opciones y cómo se declaran.
============================================================================ */

# Importante revisar la configuracion de que pasa cuando se actuliza o se eliminan datos de la tabla de la clave primaria

/*
   La clave foránea protege la relación, pero no decide sola qué hacer cuando
   cambia o desaparece la fila referenciada. Eso se declara con dos cláusulas,
   una por operación sobre la tabla padre:

   - ON UPDATE: qué pasa con las filas hijas cuando cambia el valor de la clave.
   - ON DELETE: qué pasa con las filas hijas cuando se elimina la fila padre.

   Cada una admite una acción:
   - CASCADE: propaga el cambio o el borrado a las filas hijas.
   - SET NULL: deja la clave foránea en NULL en las hijas (la columna debe
     admitir NULL).
   - RESTRICT / NO ACTION: impide la operación sobre la fila padre. En MySQL son
     equivalentes.
   - SET DEFAULT: usa el valor por defecto de la columna; InnoDB no lo admite,
     así que con este motor no se usa.

   Si no se declara ninguna, MySQL aplica NO ACTION.
*/

/* ============================================================================
   ON DELETE Y ON UPDATE: LA DECISIÓN QUE EVITA HUÉRFANOS
   ----------------------------------------------------------------------------
   - Sin acción declarada, MySQL aplica NO ACTION: borrar una fila padre con
     hijas cargadas falla en lugar de dejar filas huérfanas. Es la protección
     funcionando, no un error de la sentencia.
   - CASCADE es cómodo y peligroso: un DELETE sobre una sola fila puede borrar
     en cascada varias tablas si las relaciones se encadenan. En producción se
     decide con el diagrama a la vista.
   - SET NULL exige que la columna hija admita NULL; si es NOT NULL, esa acción
     no se puede declarar.
   - Cambiar la acción después no es gratis: hay que DROP FOREIGN KEY y volver a
     crear la restricción. Con datos reales se prueba sobre una copia.
   - En cargas masivas se suele apagar la validación con
     SET FOREIGN_KEY_CHECKS=0; eso omite la comprobación, así que hay que
     reactivarla y revisar los datos después.
============================================================================ */
