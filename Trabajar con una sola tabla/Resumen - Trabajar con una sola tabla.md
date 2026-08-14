# Resumen — Trabajar con una sola tabla (Capítulo 2)

> La idea central: **este capítulo es la base de TODO.** Acá aprendés a pedir datos de UNA tabla: elegir columnas, filtrar filas, ordenar y limitar el resultado.

Todo lo que sigue (varias tablas, resumir datos, subconsultas) se apoya en estas cláusulas.

---

## A) Lo primero: USE, SELECT, FROM

```sql
USE `default`;          -- elegís la base de datos donde trabajás

SELECT venta, venta / 1.16 AS Sin_IVA   -- elegís columnas (y podés calcular)
FROM ventas;            -- elegís la tabla
```

- **`USE`:** selecciona la base de datos activa.
- **`SELECT`:** qué columnas querés. Podés usar `*` (todo), elegir columnas, o **columnas calculadas** (operaciones matemáticas) con un alias usando `AS`.
- **`FROM`:** de qué tabla salen los datos.

**Orden importante (memorizalo):** SQL es muy estricto con el orden de las cláusulas:
`SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY → LIMIT`.

---

## B) Filtrar con WHERE

`WHERE` funciona como un **filtro**: se queda con las filas que cumplen la condición.

```sql
SELECT * FROM ventas WHERE ID_local = 2;      -- igual
SELECT * FROM ventas WHERE venta < 1000;      -- menor
SELECT * FROM ventas WHERE venta <= 1000;     -- menor o igual
SELECT * FROM ventas WHERE ID_local != 2;     -- distinto
```

**Operadores de comparación:** `=` `!=` `<>` `>` `<` `>=` `<=`.

### Combinar condiciones: AND, OR, NOT

```sql
-- AND: se deben cumplir TODAS
WHERE ID_local = 2 AND clave_producto = "pzz"

-- OR: con que UNA se cumpla, alcanza
WHERE ID_local = 2 OR clave_producto = "pzz"

-- NOT: niega una condición (equivale a !=)
WHERE NOT clave_producto = "pzz"

-- Para negar varias, el NOT va en CADA una
WHERE NOT clave_producto = "pzz" AND NOT ID_local = 2
```

### IN — atajo para varios OR

```sql
-- En vez de:
WHERE clave_producto = "clz" OR clave_producto = "pzz" OR clave_producto = "qsd"

-- Usás:
WHERE clave_producto IN ("clz", "pzz", "qsd")
```

### BETWEEN — rango (INCLUYENTE)

```sql
-- En vez de:
WHERE venta >= 500 AND venta < 1000

-- Usás (equivalente a >= y <=):
WHERE venta BETWEEN 500 AND 1000
```

- Sirve para **números, fechas y texto**. Es **incluyente** (toma los extremos).

### IS NULL / IS NOT NULL — registros vacíos

```sql
WHERE domicilio IS NULL;      -- filas SIN dato
WHERE domicilio IS NOT NULL;  -- filas CON dato
```

- **Regla clave:** un `NULL` no se compara con `=` ni `!=`. Para eso están `IS NULL` e `IS NOT NULL`.

### LIKE — búsquedas de patrones (inexactas)

Cuando no sabés el valor exacto, buscás por patrón.

| Símbolo | Significa |
|---|---|
| `%` | 0, uno o MUCHOS caracteres |
| `_` | EXACTAMENTE un carácter |

```sql
WHERE clave_producto LIKE "%z";    -- termina en "z"
WHERE clave_producto LIKE "c%";    -- empieza con "c"
WHERE clave_producto LIKE "_l_";   -- 3 letras, "l" en el medio
WHERE clave_producto LIKE "__z";   -- 3 letras, termina en "z"
```

### REGEXP — expresiones regulares (patrones avanzados)

Cuando `LIKE` se queda corto, usás `REGEXP`.

```sql
WHERE apellido REGEXP "ez";      -- CONTIENE "ez"
WHERE apellido REGEXP "^A";      -- EMPIEZA con "A"  (^ = ancla de inicio)
WHERE apellido REGEXP "ez$";     -- TERMINA en "ez"  ($ = ancla de fin)
WHERE apellido REGEXP "ez|iz";   -- contiene "ez" O "iz" (| = alternancia)
```

- `^` = comienzo, `$` = final, `|` = "o". Sin ancla, busca en cualquier parte de la cadena.

---

## C) Ordenar y limitar

### ORDER BY

```sql
ORDER BY nombre;         -- A → Z (ascendente, por defecto)
ORDER BY nombre DESC;    -- Z → A (descendente)
```

- Se puede combinar con WHERE: primero filtro, después ordeno.

### LIMIT

```sql
LIMIT 5;       -- solo los primeros 5 registros
LIMIT 5, 9;    -- salta los primeros 5 y muestra los siguientes 9 (offset, cantidad)
```

- `LIMIT offset, cantidad` es la sintaxis de MySQL. Muy usado para **paginación**.

---

## El hilo conductor

| Quiero... | Uso |
|---|---|
| Elegir columnas / calcular | `SELECT ... AS` |
| De qué tabla | `FROM` |
| Filtrar filas | `WHERE` + operadores |
| Varias condiciones (todas) | `AND` |
| Varias condiciones (alguna) | `OR` |
| Negar | `NOT` / `!=` |
| Varios valores posibles | `IN` |
| Un rango | `BETWEEN` |
| Filas vacías / con dato | `IS NULL` / `IS NOT NULL` |
| Patrón simple de texto | `LIKE` (`%`, `_`) |
| Patrón avanzado | `REGEXP` (`^`, `$`, `|`) |
| Ordenar | `ORDER BY` (ASC/DESC) |
| Limitar cantidad / paginar | `LIMIT` |
