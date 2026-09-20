# Curso SQL

Apunte personal del curso de SQL avanzado sobre MySQL. Cada archivo es la nota
de un tema.

El objetivo no es tener documentación perfecta, es tener un apunte que dentro de
seis meses reconozca como mío.

## El curso

El material de origen es **SQL Cero a Experto**: manual, base de datos Northwind
y respuestas de los ejercicios. Nada de eso está versionado acá, vive en
`Recursos/`. Lo que sí está versionado son las notas: **104 archivos `.sql`**,
uno por tema, agrupados por capítulo.

El motor es **MySQL**, y el cliente que usa el curso es **MySQL Workbench**.

## Capítulos

Los capítulos del curso, en orden:

| Cap. | Carpeta | Qué cubre |
| ---: | --- | --- |
| 2 | `Trabajar con una sola tabla` | El piso de todo: `USE`, `SELECT`, `FROM`, filtros con `WHERE` (`IN`, `BETWEEN`, `LIKE`, `REGEXP`, `IS NULL`), `ORDER BY` y `LIMIT`. Cierra con 10 ejercicios sobre Northwind. |
| 3 | `Trabajar con Varias Tablas` | Cruzar tablas: `INNER JOIN` de hasta tres tablas, `LEFT` y `RIGHT JOIN`, self join, `NATURAL JOIN`, `USING`, `CROSS JOIN`, `UNION` y joins entre bases distintas. |
| 4 | `Trabajar con Datos` | Escribir datos: `INSERT` de una y de varias filas, `UPDATE`, `DELETE`, copiar una tabla como respaldo, `TRUNCATE` y `LAST_INSERT_ID()` para encadenar altas entre tablas relacionadas. |
| 5 | `Resumir Datos` | Agregar: `MAX`, `MIN`, `SUM`, `AVG`, `COUNT`, `GROUP BY`, `HAVING` y `WITH ROLLUP`. |
| 6 | `Queries complejos` | Subconsultas ordenadas por dónde viven (`WHERE`, `SELECT`, `FROM`), `IN`, `EXISTS`, `ANY`, `ALL`, la forma correlacionada y la comparación `JOIN` contra subconsulta. |
| — | `Estructuras JSON` | Guardar un objeto JSON en una columna y leerlo con `JSON_EXTRACT` y rutas `$.clave`. |

## Bloques de diseño y administración

Temas que el curso trabaja fuera de la numeración de capítulos:

| Carpeta | Qué cubre |
| --- | --- |
| `Diseñar Bases de Datos` | La cadena de diseño antes de crear la primera tabla: conceptual → lógico → físico, normalización 1FN, 2FN y 3FN, llaves foráneas y sus restricciones, charset y colación, motores de almacenamiento, y las herramientas de Workbench (`Forward Engineer`, `Reverse Engineer`, `Sincronizar Modelo`). |
| `Modelado de datos` | Teoría del modelo relacional: claves primaria, foránea y compuesta, relaciones 1:N y 1:1, y modelado dimensional (tablas de hechos contra tablas de dimensiones). |
| `Funciones esenciales SQL` | Funciones escalares por tipo (texto, numéricas, fecha y hora) y manejo de nulos y condicionales (`IFNULL`, `COALESCE`, `IF`, `CASE`). |
| `Vistas` | Vistas sobre varios `JOIN`, vistas actualizables, y `CREATE OR REPLACE` junto a `DROP`. |
| `Procesos almacenados` | Procedimientos (`CREATE`, `CALL`, `DROP`), parámetros `IN` y `OUT`, valores por defecto, variables `DECLARE`, validaciones y funciones propias. |
| `Eventos Trigger` | Triggers sobre tablas, incluido el uso como tabla de auditoría, y eventos programados con el event scheduler. |
| `Transacciones y Concurrencia` | Propiedades ACID, una transacción real de alta de orden y pago, y bloqueos de fila entre sesiones concurrentes. |
| `Indexing` | Qué cuesta indizar, leer el `EXPLAIN` antes y después, índices compuestos, de prefijo y full-text, y cuándo un `OR` deja el índice sin usar. |
| `Asegurar bases de Datos` | Crear usuarios, revisar cuentas y privilegios en `mysql.user`, y conectar MySQL con Excel vía ODBC. |

## Resúmenes por capítulo

Los capítulos llevan además un resumen en Markdown, con el hilo conductor y
los tips que no entraron en las notas. Están en `Resumen - <tema>.md`, dentro
de la carpeta de cada uno, y cubren los capítulos 2 a 6 y JSON.

## Práctica

`Queries complejos/Practica/` es un paquete aparte: un script que arma la base
`practica_queries`, con cinco tablas de esquema espejo a Northwind pero datos de
otro negocio (una tienda de electrónica llamada ElectroHub). Adentro hay 10
desafíos con autochequeo y pistas, y las respuestas al final.

El resto de los ejercicios usa la base **Northwind** y vive suelto en la carpeta
de su capítulo, como `Ejercicios - <tema>.sql`.
