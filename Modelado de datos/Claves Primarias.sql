/* ============================================================================
   TEMA: Tipos de Claves (Primaria, Foránea y Compuesta)
   ============================================================================
   Objetivo: Dominar los mecanismos de identificación única e integridad 
   referencial entre tablas, asegurando que los cruces analíticos sean 
   exactos y computacionalmente eficientes.
============================================================================ */

# Clave primaria
-- Identificador único e irrepetible de cada fila en una tabla. 
-- Regla técnica: Implica automáticamente NOT NULL y crea un índice clustered/único.
-- Ejemplo: id_cliente INT PRIMARY KEY;

# Clave foranea
-- Columna (o conjunto de columnas) que apunta a la clave primaria de otra tabla.
-- Garantiza la integridad referencial: no puedes registrar una venta para un cliente inexistente.
-- Ejemplo: FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente);

# clave primaria compuesta
-- Clave primaria formada por dos o más columnas combinadas cuando un solo 
-- campo no basta para garantizar unicidad.
-- Ejemplo clásico en tablas puente (muchos a muchos):
-- PRIMARY KEY (id_orden, id_producto);


/* ============================================================================
   TIPS PRO & TRUCOS DE PRODUCCIÓN
   ============================================================================
   * Clave Compuesta: El orden de las columnas importa (Leftmost Prefix Rule):
     Si defines `PRIMARY KEY (id_orden, id_producto)`, el índice implícito acelera 
     consultas que busquen por `id_orden` o por ambos campos juntos. Pero si haces 
     un SELECT filtrando solo por `id_producto`, MySQL NO podrá usar ese índice 
     de forma óptima y hará un escaneo mucho más pesado.

   * Claves Foráneas en Cargas Masivas (ETLs y Data Warehouse):
     Los constraints de clave foránea (`FOREIGN KEY`) exigen que el motor verifique 
     si el registro existe antes de cada inserción. En cargas analíticas masivas 
     (millones de filas vía ETL), esto ralentiza drásticamente el proceso; por eso, 
     en bodegas de datos a menudo se deshabilitan las FKs físicas y la validación 
     se delega al pipeline de datos (Python, dbt o Airflow).

   * La trampa de las FKs con valores NULL:
     Una clave foránea admite valores `NULL` por defecto salvo que declares 
     `NOT NULL`. Si extraes datos para un reporte usando un `INNER JOIN`, todas 
     las transacciones con FK nula desaparecerán de tus totales. Si usas 
     `LEFT JOIN`, aparecerán categorizadas como `NULL` (lo que en dashboards 
     se etiqueta como "Sin Asignar" o "Desconocido").

   * ¿Cuándo conviene una Compuesta vs. un ID Autoincremental?:
     Para tablas de detalle (ej. productos dentro de un pedido o roles asignados 
     a un usuario), una clave compuesta (`id_orden` + `id_producto`) es la mejor 
     práctica: previene físicamente que el mismo producto se agregue duplicado 
     en la misma orden sin gastar almacenamiento en una columna ID artificial extra.
============================================================================ */