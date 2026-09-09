
/* ============================================================================
   TEMA: Fundamentos del Modelo Relacional y Entidades
   ============================================================================
   Objetivo: Comprender cómo estructurar la información del negocio en 
   entidades separadas conectadas mediante claves primarias, evitando la 
   duplicidad de datos y garantizando la integridad de las relaciones.
============================================================================ */

# SQL es muy importante por armar bases de datos relacionales

# Base de datos relacional sognifica que vas a guardar datos en varias tablas y puedes conectarlas

# Vamos a armar un modelo de datos. 

# Modelo de datos es un modelo abstracto que organiza elementos de datos y estandariza como se relacionan entre ellos y las propiedades de las entidades de la vida real

# En los modelos de datos exiten las claves primarias que es el dato irrepetible con el cual vamos a identificar a todas nuestras entidades

# Entidades son lo que componen las bases de datos 

# Cuando hablamos de bases de datos relacionales estamos hablando sobre la capacidad de poder despedazar los datos diferentes tablas y luego poder unirlor y trabajar con ellas con el modelo de datos


/* ============================================================================
   TIPS PRO & TRUCOS DE PRODUCCIÓN
   ============================================================================
   * "Despedazar" vs. Analizar (Normalización vs. BI):
     Separar los datos en muchas tablas evita duplicados y errores al guardar 
     (normalización). Pero para un analista, unir 8 tablas con JOINs sobre 
     millones de registros puede volver lentísimo un reporte. Por eso, en analítica 
     avanzada se usan "Modelos Estrella" (desnormalizados) diseñados para leer rápido.

   * Claves Primarias Naturales vs. Subrogadas (Error clásico):
     Nunca uses datos del mundo real como clave primaria aunque parezcan únicos 
     (evita usar RFC, DNI, CURP o correo electrónico). Las personas cambian de 
     correo y el gobierno comete errores tipográficos al emitir documentos. 
     Usa siempre un identificador numérico artificial (ID autoincremental).

   * El costo de unir tablas:
     Para que la unión (JOIN) entre tablas separadas sea instantánea y no sature 
     el servidor, las columnas que conectan ambas tablas (clave primaria y clave 
     foránea) deben tener el mismo tipo de dato exacto (ej. INT con INT) y estar indexadas.
============================================================================ */