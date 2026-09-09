/* ============================================================================
   TEMA: Modelado Dimensional (Tablas de Dimensiones vs. Tablas de Hechos)
   ============================================================================
   Objetivo: Diferenciar el almacenamiento de atributos descriptivos 
   (dimensiones) de las métricas cuantitativas (hechos) para estructurar 
   modelos analíticos optimizados para reporting y Business Intelligence.
============================================================================ */

# Las tablas de dimensiones almacenan atributos que describen a los objetos o entidades. Se guardan los catalogos

# Las tablas de hechos Almacenan medidas, metricas o hechos de un proceso. 

-- Estructura clásica en Data Warehouses (Modelo Estrella):
-- * Dimensiones (Dim): Responden al contexto (¿Quién? ¿Qué? ¿Cuándo? ¿Dónde?).
--   Ejemplo: dim_cliente, dim_producto, dim_tiempo, dim_sucursal.
-- * Hechos (Fact): Responden a los números y eventos (¿Cuánto? ¿Cuántas veces?).
--   Ejemplo: fact_ventas (monto_total, cantidad_vendida, costo_envio).


/* ============================================================================
   TIPS PRO & TRUCOS DE PRODUCCIÓN
   ============================================================================
   * Granularidad (El concepto más importante):
     Antes de crear una tabla de hechos, define qué representa exactamente una 
     sola fila. ¿Es un ticket de venta completo o cada producto individual 
     dentro del ticket? Mezclar granularidades es el error que más reportes 
     financieros arruina en Power BI y Tableau.

   * Claves Subrogadas vs. Claves del Negocio:
     En analítica profesional, las dimensiones no usan el ID del sistema 
     operativo original (Business Key). Se genera un ID numérico propio 
     (`sk_cliente INT AUTO_INCREMENT`). Así, si el ERP cambia de sistema o se 
     fusionan dos bases de datos, tu Data Warehouse no colapsa.

   * Dimensiones que cambian en el tiempo (SCD Tipo 2):
     Como administrador sabes que si un cliente vivía en Morelia en 2024 y 
     se mudó a Guadalajara en 2025, no puedes sobreescribir su ciudad; si lo 
     haces, alterarías la historia de ventas por estado del año pasado. Se 
     crea una fila nueva con fechas de vigencia (`fecha_inicio`, `fecha_fin`).

   * Factless Fact Tables (Tablas de hechos sin números):
     Hay tablas de hechos que no tienen dinero ni cantidades, solo registran 
     la ocurrencia de un evento (ej. asistencia de empleados, registros de login 
     o clics en la web). En analítica se miden simplemente contando filas con `COUNT()`.
============================================================================ */