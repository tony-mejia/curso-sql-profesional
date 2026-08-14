# Resumen — Trabajar con Varias Tablas (Capítulo 3)

> La idea central: **los datos de un negocio viven repartidos en varias tablas.** Este capítulo te enseña a COMBINARLAS para responder preguntas que cruzan datos.

La herramienta reina es el **JOIN**. Al final, `UNION` y `CROSS JOIN` son primos que también combinan, pero de otra forma.

---

## A) JOIN (INNER JOIN) — el principal

Combina filas de dos o más tablas basándose en una **columna relacionada** (una llave foránea).

```sql
SELECT v.ventas_id, l.direccion, e.nombre
FROM ventas v
JOIN local l     ON v.ID_local      = l.ID_Local
JOIN empleados e ON v.venta_empleado = e.ID_empleado;
```

- **Solo devuelve las filas que tienen coincidencia en AMBAS tablas.** Si una fila no tiene pareja, desaparece del resultado.
- Podés encadenar varios `JOIN` para cruzar 3, 4 o más tablas.
- Usá **alias** (`v`, `l`, `e`) para escribir menos y evitar ambigüedad cuando dos tablas tienen columnas con el mismo nombre.

**Caso real:** "dame cada venta con la dirección del local y el nombre del empleado que la hizo".

---

## B) JOIN a través de bases de datos

Podés cruzar tablas de **diferentes bases de datos** (o schemas) calificando la tabla con su base:

```sql
USE periodos;

SELECT p.fecha, e.nombre
FROM periodo1 p
JOIN default.empleados e      -- "default" es OTRA base
  ON p.ID_empleado = e.ID_empleado;
```

- Sintaxis: `base.tabla`.
- **Caso real:** "cruzar datos de producción con datos de RRHH que están en otro schema".

---

## C) Joins externos — LEFT y RIGHT

Los `JOIN` normales pierden las filas sin pareja. Los externos las **conservan** (rellenando con NULL).

```sql
SELECT *
FROM ventas v
LEFT JOIN empleados e ON v.venta_empleado = e.ID_empleado;
-- TODAS las filas de la izquierda (ventas) + lo que coincida de empleados

SELECT *
FROM ventas v
RIGHT JOIN empleados e ON v.venta_empleado = e.ID_empleado;
-- TODAS las filas de la derecha (empleados) + lo que coincida de ventas
```

- **`LEFT JOIN`:** todo lo de la tabla de la izquierda, y lo que coincida de la derecha (lo que no coincide queda NULL).
- **`RIGHT JOIN`:** lo mismo pero al revés.
- **Caso real:** "todos los empleados, y sus ventas si tienen" (RIGHT JOIN) → acá aparecen los empleados que **no vendieron nada**.

---

## D) Self Join — una tabla consigo misma

Cuando una tabla se relaciona **consigo misma** (por ejemplo, empleados que tienen un jefe que también es empleado).

```sql
SELECT e.nombre, p.nombre AS Gerente
FROM empleados e
JOIN empleados p ON e.ID_Gerente = p.ID_empleado;
```

- La misma tabla aparece **dos veces con dos alias** distintos (`e` y `p`).
- **Caso real:** "cada empleado y quién es su gerente", "cada producto y su producto padre", jerarquías.

---

## E) Atajos para el JOIN: USING y NATURAL JOIN

### USING — cuando la columna se llama igual en ambas tablas

```sql
-- En vez de:
JOIN local l ON v.ID_local = l.ID_Local

-- Usás (si la columna se llama IGUAL):
JOIN local l USING (ID_local)
```

### NATURAL JOIN — unión automática

```sql
NATURAL JOIN local l;
```

- SQL busca **automáticamente las columnas con el mismo nombre** y une por ellas.
- ⚠️ **Peligroso:** es implícito y frágil. Si no hay columnas iguales, te da un producto cruzado. La mayoría de la gente prefiere el `JOIN ... ON` explícito para tener control total.

---

## F) CROSS JOIN — producto cartesiano

```sql
SELECT * FROM productos p CROSS JOIN ingredientes i;
```

- Combina **cada fila de A con cada fila de B** (A × B filas). Si tenés 10 productos y 8 ingredientes → 80 filas.
- **Caso real:** casi nunca se usa "a propósito". Sirve para entender qué pasa cuando un JOIN no tiene `ON`. Genera explosión de filas.

---

## G) UNION — apilar resultados (no es un JOIN)

`UNION` combina el resultado de dos o más `SELECT` **verticalmente** (uno debajo del otro), no horizontalmente.

```sql
SELECT producto    FROM productos
UNION
SELECT ingredientes FROM ingredientes;
```

- **Regla:** ambos SELECT deben devolver la **misma cantidad de columnas** (y tipos compatibles).
- `UNION` elimina duplicados; `UNION ALL` los conserva.

---

## El hilo conductor

| Quiero... | Uso |
|---|---|
| Filas que coinciden en 2 tablas | `INNER JOIN ... ON` |
| Todo de la izquierda + coincidencias | `LEFT JOIN` |
| Todo de la derecha + coincidencias | `RIGHT JOIN` |
| Relacionar una tabla consigo misma | `SELF JOIN` (2 alias) |
| Cruce entre bases distintas | `base.tabla` |
| Atajo si la columna se llama igual | `USING` |
| Unión automática (⚠️ frágil) | `NATURAL JOIN` |
| Cada fila × cada fila | `CROSS JOIN` |
| Apilar resultados de 2 SELECT | `UNION` / `UNION ALL` |

> **Regla mental:** `JOIN` une **columnas** (horizontal, por llave). `UNION` apila **filas** (vertical, mismo nº de columnas).
