/* ============================================================================
   TEMA: Reverse Engineer de MySQL Workbench
   ============================================================================
   Reverse Engineer parte de una base que ya existe y reconstruye el diagrama
   desde sus objetos: es el camino inverso al Forward Engineer.
============================================================================ */

# Es cuando tienes el esquema listo pero quieres converirlo en un modelo 

/*
   Reverse Engineer parte de una base que ya está en el servidor y arma el
   diagrama desde ahí. Lee los objetos reales: tablas, columnas y sus tipos,
   índices, claves primarias y llaves foráneas. Con eso reconstruye las
   relaciones del modelo.

   Por eso necesita una conexión viva a la base, no un archivo de script: lo
   que se lee es la base existente. El resultado es el modelo editable, que
   sirve para documentar lo que hay o para continuar el diseño desde ahí.

   Forward Engineer y Reverse Engineer son las dos direcciones del mismo flujo:
   uno baja el modelo al servidor y el otro levanta el modelo desde el servidor.
*/

/* ============================================================================
   REVERSE ENGINEER: DOCUMENTAR UN ESQUEMA QUE YA ESTÁ EN EL SERVIDOR
   ----------------------------------------------------------------------------
   - El punto de partida manda: acá se parte de la base, no del diagrama. Si el
     esquema se cambió a mano con ALTER TABLE, el modelo viejo ya no lo refleja
     y esta es la vía para volver a ver lo que hay.
   - Se lee la base tal como está en ese momento: si después cambia, el modelo
     queda desactualizado. Conviene volver a correrlo cuando se sospecha una
     diferencia.
   - El modelo reconstruido documenta el esquema físico y sirve para revisar
     relaciones y llaves foráneas de una base heredada, o para empezar un
     diseño nuevo a partir de lo que ya existe.
   - El diagrama no reemplaza a SHOW CREATE TABLE como fuente exacta de la
     definición de una tabla: opciones que el modelo no representa quedan solo
     en el servidor.
============================================================================ */
