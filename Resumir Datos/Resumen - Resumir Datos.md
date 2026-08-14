# Resumen — Resumir Datos (Capítulo 5)

> La idea central: **pasar del detalle (filas) al RESUMEN (totales).** En vez de ver 10.000 ventas, querés saber: ¿cuántas hubo? ¿cuál fue la más grande? ¿cuánto suma cada local?

Acá entran las **funciones de agregación** y `GROUP BY`.

---

## A) Funciones de agregación

Son operaciones matemáticas sobre una columna que devuelven **UN solo valor**.

```sql
SELECT MAX(venta) FROM ventas;   -- la venta más grande
SELECT SUM(venta) FROM ventas;   -- suma de todas las ventas
SELECT AVG(venta) FROM ventas;   -- promedio
```

| Función | Qué devuelve | NULLs |
|---|---|---|
| `COUNT(col)` | nº de registros | NO los cuenta |
| `COUNT(*)` | nº total de filas | (cuenta todo) |
| `SUM(col)` | suma | los ignora |
| `AVG(col)` | promedio | los ignora |
| `MAX(col)` | valor máximo | los ignora |
| `MIN(col)` | valor mínimo | los ignora |

### COUNT + DISTINCT

```sql
-- Cuenta solo los valores DIFERENTES (sin repetidos)
SELECT COUNT(DISTINCT venta_empleado) AS empleados_diferentes
FROM ventas;
```

- `COUNT(DISTINCT col)` cuenta los valores únicos. Muy útil para "¿cuántos clientes distintos compraron?".

### El truco de MAX sin agregación

Para saber NO solo la venta máxima, sino **quién/qué la hizo**, usás orden + límite:

```sql
SELECT venta, venta_empleado, fecha
FROM ventas
ORDER BY venta DESC
LIMIT 1;   -- la fila con la venta más grande
```

---

## B) GROUP BY — resumir POR GRUPO

`MAX`/`SUM` solos te dan UN total global. `GROUP BY` te da el total **por cada grupo**.

```sql
SELECT ID_local, SUM(venta)
FROM ventas
GROUP BY ID_local;      -- suma de ventas por cada local

SELECT venta_empleado, SUM(venta)
FROM ventas
GROUP BY venta_empleado
ORDER BY SUM(venta) DESC;   -- empleados con más ventas primero
```

- **Regla de oro:** en un `SELECT` con `GROUP BY`, TODA columna que no esté dentro de una función de agregación DEBE ir en el `GROUP BY`. Si no, SQL te da error o resultados raros.
- Se coloca **después** de `FROM`/`WHERE`.

**Caso real:** "ventas por local", "gastos por categoría", "pedidos por cliente".

---

## C) HAVING — filtrar resultados AGRUPADOS

`WHERE` filtra filas ANTES de agrupar. `HAVING` filtra GRUPOS DESPUÉS de agrupar.

```sql
-- ❌ ESTO NO FUNCIONA (WHERE no puede filtrar un total)
SELECT ID_local, clave_producto, SUM(venta) AS venta_total
FROM ventas
WHERE venta_total > 1500      -- error: venta_total aún no existe
GROUP BY ID_local, clave_producto;

-- ✅ ESTO SÍ
SELECT ID_local, clave_producto, SUM(venta) AS venta_total
FROM ventas
GROUP BY ID_local, clave_producto
HAVING venta_total > 1500;    -- filtro sobre el total ya calculado
```

- `WHERE` → filtra **filas** (antes del grupo).
- `HAVING` → filtra **grupos** (después del `GROUP BY`, sobre agregados).

---

## D) WITH ROLLUP — subtotales y total general

Agrega filas de **subtotal y total general** al final del `GROUP BY`.

```sql
SELECT ID_local, SUM(venta) AS venta_total
FROM ventas
GROUP BY ID_local WITH ROLLUP;
-- devuelve cada local + UNA fila final con el total de todos

SELECT ID_local, clave_producto, SUM(venta)
FROM ventas
GROUP BY ID_local, clave_producto WITH ROLLUP;
-- subtotales por local Y total general
```

- Las filas extra aparecen con `NULL` en la columna agrupada (indicando "total").
- **⚠️ MySQL-specific:** otros motores usan `ROLLUP` de otra forma o `GROUPING SETS`.
- **Dato del curso:** para análisis rápido en SQL va bien, pero para exportar a Excel o visualizar, esas filas de NULL ensucian la tabla (hay que limpiarlas). Por eso en producción se prefiere calcular subtotales aparte.

---

## El hilo conductor

| Quiero saber... | Uso |
|---|---|
| Total general | `SUM` / `AVG` / `MAX` / `MIN` / `COUNT` |
| Cuántos hay | `COUNT(*)` |
| Cuántos distintos | `COUNT(DISTINCT col)` |
| Por grupo (local, cliente, categoría) | `GROUP BY col` |
| Filtrar ANTES de agrupar | `WHERE` |
| Filtrar DESPUÉS de agrupar (sobre totales) | `HAVING` |
| Subtotales + total general | `WITH ROLLUP` |

> **Regla mental:** `WHERE` → filas. `GROUP BY` → grupos. `HAVING` → grupos filtrados. En ese orden se ejecuta: `WHERE` primero, después `GROUP BY`, después `HAVING`.
