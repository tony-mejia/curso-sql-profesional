/* ============================================================================
   TEMA: Relaciones Uno a Uno (1:1) en el Modelado de Datos
   ============================================================================
   Objetivo: Comprender cuándo y por qué separar atributos de una entidad en 
   dos tablas distintas donde cada registro de la tabla A se vincula a un 
   único registro en la tabla B.
============================================================================ */

#Relacion 1 a 1

# Dentro del modelado de datros existen diferentes maneras de armar relaciones entre tablas

-- Estructura técnica común en MySQL:
-- Para forzar que sea estrictamente 1:1, la clave foránea (FK) en la tabla 
-- secundaria DEBE tener una restricción UNIQUE. Sin el UNIQUE, el motor 
-- permitirá que se convierta en una relación 1 a Muchos.


/* ============================================================================
   TIPS PRO & TRUCOS DE PRODUCCIÓN
   ============================================================================
   * ¿Por qué no meter todo en una sola tabla?:
     En la vida real, una relación 1:1 se usa por tres razones clave:
     1. Seguridad: Separar datos sensibles (ej. `empleado` vs. `sueldo_bancario`) 
        para restringir permisos de lectura a ciertos usuarios o analistas.
     2. Rendimiento: Si tienes columnas pesadas que casi nunca se leen (textos 
        largos, fotos en BLOB, JSONs), moverlas a una tabla secundaria hace que 
        las consultas frecuentes sobre la tabla principal vuelen en memoria.
     3. Datos opcionales: Evitar tablas llenas de columnas con valores `NULL` 
        si solo el 5% de los registros tiene esa información extra.

   * La trampa del UNIQUE (Error de diseño):
     Si conectas `cliente` con `datos_fiscales` mediante `cliente_id`, pero no 
     defines `cliente_id` como `UNIQUE` en la tabla secundaria, un usuario 
     podría registrar dos domicilios fiscales para el mismo cliente. En ese punto, 
     tu modelo 1 a 1 se rompió y pasó a ser 1 a Muchos.

   * Peligro mortal para el Analista (Métricas infladas):
     Si haces un `LEFT JOIN` con una tabla que creías que era 1:1, pero que por 
     falta de restricciones tiene filas duplicadas, tus funciones de agregación 
     (`SUM`, `COUNT`) se duplicarán silenciosamente, arrojando reportes de ventas 
     inflados en Power BI o reportes ejecutivos.
============================================================================ */