/* ============================================================================
   TEMA: Relación Uno a Muchos (1:N)
   ============================================================================
   Objetivo: Comprender la relación más común del modelo relacional, donde 
   un registro de una tabla maestra (catálogo) se vincula con múltiples 
   registros de eventos (histórico o transaccional).
============================================================================ */

# Relacion 1 a Muchos

# es cuando un catalogo y un historico

-- Estructura técnica común en MySQL:
-- 1. Tabla Maestra / Catálogo (Lado 1): Contiene la clave primaria (PK).
--    Ejemplo: 'clientes', 'productos', 'sucursales'.
-- 2. Tabla Transaccional / Histórico (Lado Muchos): Contiene la clave foránea (FK).
--    NO lleva restricción UNIQUE, permitiendo que un mismo ID de cliente 
--    aparezca registrado cientos o miles de veces conforme compra.


/* ============================================================================
   TIPS PRO & TRUCOS DE PRODUCCIÓN
   ============================================================================
   * El núcleo de Business Intelligence (Dimensiones vs. Hechos):
     Tu intuición es exacta. En analítica de datos, a esto se le llama 
     "Modelo Dimensional": tus catálogos se convierten en Tablas de Dimensión 
     (el "quién", "dónde", "qué") y tus históricos se convierten en Tablas 
     de Hechos o Facts (las transacciones numéricas, ventas y métricas).

   * La trampa del "Fan-out" (Duplicación accidental de métricas):
     Al unir (JOIN) un catálogo con un histórico, las filas del catálogo se 
     repiten tantas veces como registros históricos existan.
     Peligro analítico: Si haces `SUM(cliente.limite_credito)` después de 
     unir con 10 compras, sumarás el límite de crédito 10 veces, falseando 
     tus dashboards financieros. Los atributos del catálogo casi nunca se suman.

   * Regla de Auditoría: ¿Qué pasa si borran un elemento del catálogo?:
     Nunca uses `ON DELETE CASCADE` en tablas históricas. Si alguien elimina un 
     producto del catálogo y la base borra en cascada todas las ventas pasadas 
     de ese producto, destruyes el balance contable y la serie histórica para 
     reporting. En producción se usa borrado lógico (`activo = 0`).

   * Clave para consultas rápidas:
     En tablas históricas con millones de filas, la columna que actúa como 
     clave foránea (el ID que apunta al catálogo) DEBE estar indexada. Si no 
     lo está, un JOIN para un reporte mensual forzará al motor a leer millones 
     de registros uno por uno.
============================================================================ */