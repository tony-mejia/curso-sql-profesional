/* ============================================================================
   TEMA: Forward Engineer de MySQL Workbench
   ============================================================================
   Objetivo: Ubicar Forward Engineer en el flujo del modelado: el modelo físico
   ya está dibujado y esta herramienta lo convierte en las tablas reales del
   servidor.
============================================================================ */

#Es una herramienta de MySQL Workbench que transforma el modelo fisico a tablas

/*
   Forward Engineer es el paso que baja el modelo al servidor: a partir del
   diagrama físico genera las sentencias de definición (DDL) y las ejecuta
   contra la base. Crear las tablas, sus columnas y sus restricciones deja de
   hacerse a mano.

   Tiene dos momentos, y el primero es el que conviene mirar: Workbench muestra
   el script que va a ejecutar y recién después lo aplica. Ese script se puede
   revisar, guardar junto al proyecto y volver a correr sin depender de la
   herramienta abierta.

   El orden del script es parte de su corrección: la base se crea antes de
   seleccionarla, la tabla referenciada antes que la que la referencia, y las
   columnas antes que sus índices y llaves foráneas.
*/

#Herramientas como DBeaver free no tiene esta opcion

/*
   Conviene leer esa línea con cuidado, porque la diferencia es de dónde se
   parte. Forward Engineer parte de un modelo y llega a las tablas. DBeaver free
   sí dibuja diagramas y exporta DDL, pero lo hace desde una base que ya existe:
   ese es el camino inverso. Para modelar primero y recién después crear las
   tablas, la pieza es la de Workbench.
*/

/* ============================================================================
   LA VUELTA COMPLETA: MODELO Y BASE EN DOS DIRECCIONES
   ----------------------------------------------------------------------------
   - Forward Engineer va del modelo físico a la base: es el que se usa para
     crear por primera vez las tablas del diseño.
   - Reverse Engineer va de la base al modelo: es el que se usa cuando lo que
     existe es la base y hay que reconstruir el diagrama.
   - Los dos operan sobre el mismo modelo, en direcciones opuestas. El archivo
     del modelo (.mwb en Workbench) es el punto medio entre las dos.
   - El DDL que genera es un archivo más del proyecto: se revisa y se versiona
     antes de aplicarlo a un servidor que ya tiene datos.
============================================================================ */
