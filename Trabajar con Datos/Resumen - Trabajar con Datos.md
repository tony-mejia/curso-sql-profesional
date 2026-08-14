# Resumen — Trabajar con Datos (Capítulo 4)

> La idea central: **hasta ahora solo LEÍAS datos. Este capítulo te enseña a ESCRIBIRLOS:** insertar, modificar y eliminar registros, además de copiar tablas como backup.

En términos técnicos, esto es el **DML** (Data Manipulation Language). Son las operaciones que MUTAN los datos, así que cuidado: **no hay "deshacer" automático.**

---

## A) INSERT — agregar filas

### Una fila

```sql
INSERT INTO ingredientes (Ingredientes)
VALUES ("Aceituna");

INSERT INTO ingredientes (Ingredientes, clave_ingrediente)
VALUES ("Salami", "sal");
```

### Varias filas a la vez

```sql
INSERT INTO ingredientes (Ingredientes)
VALUES ("BBQ"), ("Jamon"), ("J. Serrano");

INSERT INTO ingredientes (Ingredientes, clave_ingrediente, precio_porcion)
VALUES ("champiñon", "champ", 34), ("queso", "qso", 45);
```

- Especificás las **columnas** y sus **valores**. Si no especificás columnas, SQL espera valores para TODAS en orden (y no podés saltarte ninguna).

---

## B) UPDATE — modificar filas existentes

### Una fila (con WHERE puntual)

```sql
UPDATE ingredientes
SET Ingredientes = "pina", clave_ingrediente = "pin"
WHERE ingredientes_id = 5;
```

### Varias filas (el WHERE define cuáles)

```sql
UPDATE ventas
SET venta = 777
WHERE ID_local = 1;   -- modifica TODAS las ventas del local 1
```

- **⚠️ Regla de oro:** NUNCA un `UPDATE` sin `WHERE` (a menos que quieras modificar TODO, que casi nunca es el caso).
- Podés actualizar varias columnas con un solo `SET ... , ...`.

---

## C) DELETE — eliminar filas

```sql
DELETE FROM ingredientes WHERE ingredientes_id = 11;

DELETE FROM ingredientes WHERE ingredientes_id BETWEEN 21 AND 22;
```

- **⚠️ Misma regla:** siempre con `WHERE`. `DELETE FROM tabla;` sin WHERE borra TODA la tabla.
- Es definitivo: los registros eliminados no se recuperan.

---

## D) Copiar una tabla (backup)

### CREATE TABLE ... AS SELECT

```sql
CREATE TABLE archivo_ventas AS
SELECT * FROM ventas;
```

- Crea una copia completa de la tabla (estructura + datos). Ideal como **backup** antes de tocar datos.

### INSERT INTO ... SELECT (copiar solo algunas filas)

```sql
INSERT INTO archivo_ventas
SELECT * FROM ventas
WHERE venta > 1000;
```

- Copia a una tabla ya existente solo las filas que cumplen la condición.

### TRUNCATE (vaciar una tabla)

- Elimina **todos** los registros de una tabla (más rápido que DELETE, y reinicia contadores). Se hace por herramientas o con `TRUNCATE TABLE`.

---

## E) Modificar con una subconsulta

Podés usar una subconsulta como **filtro** del UPDATE.

```sql
-- Aumentar 16% (1.16) las ventas del local cuya zona es "D"
UPDATE archivo_ventas
SET venta = venta * 1.16
WHERE ID_local = (SELECT id_local FROM local WHERE Letra_zona = "D");

-- Lo mismo pero para varios locales (zona D o C)
UPDATE archivo_ventas
SET venta = venta * 1.16
WHERE ID_local IN (SELECT id_local FROM local WHERE Letra_zona IN ("D","C"));
```

- Con `=` si la subconsulta devuelve UN valor; con `IN` si devuelve varios.
- Esto ya adelanta el Capítulo 6 (subconsultas).

---

## F) Insertar en varias tablas relacionadas — LAST_INSERT_ID()

Cuando insertás en una tabla y necesitás el **id autogenerado** para insertar en una tabla hija.

```sql
INSERT INTO ventas (ID_local, clave_producto, venta)
VALUES (2, "pzz", 233);

-- LAST_INSERT_ID() devuelve el id de la ÚLTIMA inserción
INSERT INTO ventas_detalle
VALUES (LAST_INSERT_ID(), "Llevar");
```

- **Caso real:** "registrar una venta y su detalle" (tabla padre → tabla hija con su llave foránea).
- Importante: `LAST_INSERT_ID()` devuelve el id de la **última** inserción que hiciste en esa conexión.

---

## El hilo conductor (CRUD)

| Operación | Comando |
|---|---|
| Agregar una fila | `INSERT INTO ... VALUES (...)` |
| Agregar varias filas | `INSERT INTO ... VALUES (...), (...)` |
| Modificar filas | `UPDATE ... SET ... WHERE ...` |
| Eliminar filas | `DELETE FROM ... WHERE ...` |
| Vaciar tabla completa | `TRUNCATE TABLE` |
| Copiar tabla (backup) | `CREATE TABLE ... AS SELECT ...` |
| Copiar filas filtradas | `INSERT INTO ... SELECT ... WHERE ...` |
| Modificar con filtro dinámico | `UPDATE ... WHERE IN (subconsulta)` |
| Insertar en tabla hija | `LAST_INSERT_ID()` |

> **Resumen de seguridad:** `INSERT` agrega, `UPDATE` cambia, `DELETE` borra. Los tres mutan datos. Siempre pensá el `WHERE` antes de correr.
