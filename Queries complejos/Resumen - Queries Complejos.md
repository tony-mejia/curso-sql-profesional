# Resumen — Queries Complejos (Capítulo 6)

> La idea central: **todas las lecciones de este capítulo son variaciones de UNA sola idea: la subconsulta.**

Una **subconsulta** es una consulta adentro de otra. Lo que cambia es **dónde la metés** (WHERE, SELECT, FROM) y **qué comparación hacés**.

---

## A) Subconsultas en el WHERE (para FILTRAR filas)

### 1. Subconsulta escalar — comparar contra un número
Devuelve **UN solo valor** y comparás cada fila contra él.

```sql
WHERE Edad > (SELECT AVG(Edad) FROM empleados)
```

- **Para qué sirve:** comparar cada fila contra un total general (promedio, máximo, mínimo, suma).
- **Caso real:** "productos más caros que el promedio", "empleados que cobran más que el sueldo promedio".

### 2. Operador IN — comparar contra una LISTA
`IN` compara contra un conjunto de valores que devuelve la subconsulta.

```sql
WHERE ID_empleado IN (SELECT DISTINCT venta_empleado FROM ventas)
```

- **Para qué sirve:** filtrar por "pertenencia" a un grupo.
- **Caso real:** "clientes que hicieron al menos una compra", "productos de categorías en promoción".

### 3. EXISTS / NOT EXISTS — pregunta booleana ("¿hay al menos uno?")
Devuelve VERDADERO/FALSO según si la subconsulta devuelve al menos una fila. No importa QUÉ devuelve, solo SI devuelve.

```sql
WHERE EXISTS (SELECT 1 FROM ventas WHERE venta_empleado = e.ID_empleado)
```

- **Para qué sirve:** comprobar existencia de relación. MUY rápido en tablas gigantes (cortocircuito: se detiene en la primera coincidencia).
- **Caso real:** "¿este cliente compró alguna vez?". `NOT EXISTS` = "clientes que NUNCA compraron".
- **Dato clave:** `NOT EXISTS` es inmune a los NULL; `NOT IN` con un NULL en la lista puede no devolver nada.

### 4. ANY — "mayor que AL MENOS uno"
La condición se cumple si es verdad para cualquiera de los valores.

- **Reglas de oro:**
  - `> ANY` = **mayor que el MÍNIMO**
  - `= ANY` = igual que `IN`
  - `< ANY` = menor que el máximo
- **Caso real:** "ventas mayores que cualquiera de las del local 2".

### 5. ALL — "mayor que TODOS"
Se cumple solo si es verdad para todos los valores.

- **Reglas de oro:**
  - `> ALL` = **mayor que el MÁXIMO**
  - `< ALL` = menor que el mínimo
- **Caso real:** "el producto más caro que todos los de su proveedor".

### 6. Subconsulta correlacionada — la que "mira" la fila actual
A diferencia de las anteriores (que se ejecutan una sola vez), esta **depende de la fila externa** y se recalcula por cada fila.

```sql
WHERE venta > (SELECT AVG(venta) FROM ventas WHERE ID_local = v.ID_local)
--                                          ^^^^^^^^^^^^ el "puente" que correlaciona
```

- **Para qué sirve:** comparar cada fila contra el promedio/máximo **de SU PROPIO grupo** (no el global).
- **Caso real:** "ventas por encima del promedio de su propio local", "productos más caros que el promedio de su propia categoría".
- **Regla:** siempre usá alias para evitar ambigüedad (la `v` del ejemplo).

---

## B) Subconsulta en el SELECT — `Consultas dentro del Select.sql`

Una subconsulta **escalar** (un solo valor) como columna calculada, repetida fila por fila.

```sql
SELECT ventas_id, venta,
       (SELECT AVG(venta) FROM ventas) AS promedio,
       venta - (SELECT AVG(venta) FROM ventas) AS diferencia
FROM ventas;
```

- **Para qué sirve:** agregar métricas por fila junto al detalle (comparar cada fila contra el total).
- **Caso real:** "por cada cliente, su cantidad de pedidos y su suma de envíos".
- **Regla:** SIEMPRE debe devolver UNA columna y UNA fila. Si devuelve más, falla.
- **Forma moderna:** `AVG(...) OVER()` (funciones de ventana), más eficiente en tablas grandes.

---

## C) Subconsulta en el FROM — `Consultas dentro de From.sql`

Tomás el resultado de una consulta y lo usás **como una tabla temporal** para consultar encima.

```sql
SELECT * FROM (
    SELECT ..., venta - promedio AS delta
    FROM ventas
) AS t
WHERE delta > 100;   -- filtrás sobre una columna CALCULADA
```

- **Para qué sirve:** filtrar u operar sobre un campo **calculado** que aún no existe en la tabla. Por el orden de ejecución de SQL, no podés usar `delta` en un `WHERE` normal; metiéndolo en el FROM, ya existe.
- **Regla:** la tabla derivada SIEMPRE necesita alias, o SQL tira error.
- **Caso real:** "total de unidades por producto, pero solo los que superan el promedio global".
- **Forma moderna:** CTE (`WITH ... AS`), se lee de arriba hacia abajo y evita el "código espagueti".

---

## D) JOIN vs Subconsulta — `Join VS Subquery.sql`

**¿Por qué usar JOIN en vez de subconsulta?**

- **JOIN** te trae **más información** (columnas de AMBAS tablas). Si necesitás mostrar datos de las dos, usá JOIN.
- **Subconsulta** sirve para **filtrar** (¿existe? ¿pertenece?) cuando solo querés filas de UNA tabla.
- Con `LEFT JOIN ... WHERE v.ventas_id IS NULL` encontrás los que NO vendieron, cosa que `NOT IN` no te deja (por el tema NULL).

---

## El hilo conductor

| Pregunta de negocio | Herramienta |
|---|---|
| ¿Mayor/menor que el total? | Subconsulta escalar (`AVG`, `MAX`) |
| ¿Está en esta lista/grupo? | `IN` |
| ¿Existe al menos uno? | `EXISTS` / `NOT EXISTS` |
| ¿Mayor que al menos uno? | `ANY` (= mayor que el mínimo) |
| ¿Mayor que todos? | `ALL` (= mayor que el máximo) |
| ¿Mejor que el promedio de SU grupo? | Correlacionada |
| ¿Mostrar métricas junto al detalle? | Subconsulta en `SELECT` |
| ¿Filtrar sobre un cálculo? | Subconsulta en `FROM` |
| ¿Necesito columnas de dos tablas? | `JOIN` |
