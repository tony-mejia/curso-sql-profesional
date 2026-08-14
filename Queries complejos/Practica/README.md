# Práctica — Queries Complejos (Capítulo 6)

Pack de práctica para interiorizar los conceptos del capítulo **"Queries Complejos"** antes de (o mientras) resolvés los ejercicios del manual **"Video 7 - Capítulo 6"**.

**La idea:** los 10 desafíos usan las **mismas tablas y columnas** que tu base Northwind, pero con **otro negocio** (una tienda de electrónica llamada "ElectroHub"). Así practicás los mismos patrones con datos distintos y no podés copiar las respuestas: lo que aprendés te queda para el laburo real.

## Qué hay en esta carpeta

| Archivo | Qué es |
|---|---|
| `00_setup.sql` | Crea la base `practica_queries` y carga todos los datos. Ejecutalo una vez. |
| `01_desafios.sql` | Los 10 desafíos: pregunta de negocio + concepto + autocheck + espacio para escribir. |
| `02_respuestas.sql` | Las respuestas. ⛔ NO abrir hasta haber intentado todo. |

## Cómo usarlo

1. **Ejecutá `00_setup.sql`** completo en DBeaver: abrí el archivo (`Ctrl+O`) y presioná **`Alt+X`** (Execute SQL Script). Te crea y carga la base `practica_queries`.
2. **Abrí `01_desafios.sql`**, leé el desafío y escribí tu consulta en el espacio indicado. Para correr solo TU consulta: seleccioná el texto y presioná **`Ctrl+Enter`** (o el botón ▶).
3. **Verificá con el autocheck** (cantidad de filas) usando el truco de `COUNT(*)` que está explicado arriba del archivo.
4. Si te trabás, usá las **pistas** al final de `01_desafios.sql`.
5. **Recién al final**, compará con `02_respuestas.sql`. No hace falta que tu solución sea idéntica; lo que importa es que devuelva lo mismo.

> **Tip DBeaver:** si después de correr `00_setup.sql` no ves la base nueva en el panel izquierdo (Database Navigator), presioná `F5` para refrescar. Los archivos ya traen `USE practica_queries;` adentro, así que no necesitás cambiar de esquema a mano.

## El modelo de datos

Base `practica_queries`, 5 tablas (espejo de tu Northwind):

```
suppliers (id, company, city, state_province, country_region, email_address)
    │
    │  products.supplier_ids  →  referencia al id del proveedor
    ▼
products (id, product_code, product_name, standard_cost, list_price,
          category, supplier_ids)
    │
    │  order_details.product_id
    ▼
order_details (id, order_id, product_id, quantity, unit_price, discount)
    │
    │  order_details.order_id
    ▼
orders (id, customer_id, order_date, shipped_date, ship_city,
        ship_state_province, ship_country_region, shipping_fee, payment_type)
    │
    │  orders.customer_id
    ▼
customers (id, company, last_name, first_name, email_address, city,
           state_province, country_region, job_title)
```

Datos aproximados: 6 proveedores · 22 productos (5 categorías) · 12 clientes · 35 órdenes · 73 líneas de detalle.

## Mapa: desafío ↔ concepto ↔ tu lección ↔ ejercicio del manual

| Desafío | Concepto | Tu lección (`Queries complejos/`) | Ejercicio del manual |
|---|---|---|---|
| 1 | Subconsulta correlacionada (vs promedio de su grupo) | `Consultas Correlacionadas.sql`, `Subconsultas.sql` | 1 |
| 2 | Operador `IN` | `Operador IN.sql` | 2 |
| 3 | `JOIN` vs subconsulta en `FROM` | `Join VS Subquery.sql`, `Consultas dentro de From.sql` | 3 |
| 4 | Operador `ALL` | `All.sql` | 4 |
| 5 | Operador `ANY` | `Any.sql` | 5 |
| 6 | Subconsulta correlacionada | `Consultas Correlacionadas.sql` | 6 |
| 7 | `EXISTS` / `NOT EXISTS` | `Exists.sql` | 7 |
| 8 | Subconsultas escalares en `SELECT` | `Consultas dentro del Select.sql` | 8 |
| 9 | Subconsulta en `FROM` (derivada) + promedio global | `Consultas dentro de From.sql` | 9 |
| 10 | `EXISTS` + correlación (combo) | `Exists.sql`, `Consultas Correlacionadas.sql` | 10 |

## Recordatorios clave (sacados de tus propias lecciones)

- **`IN` vs `EXISTS`:** `IN` arma una lista; `EXISTS` hace cortocircuito (se detiene al encontrar la primera coincidencia). En tablas gigantes, `EXISTS` suele ganar.
- **`NOT EXISTS` es inmune a los NULL;** `NOT IN` con un `NULL` en la lista puede no devolver nada.
- **Tabla derivada (subconsulta en `FROM`):** siempre necesita alias, si no SQL tira error. Y solo "vive" durante la ejecución de la consulta.
- **Subconsulta escalar (en `SELECT`):** debe devolver UNA columna y UNA fila. Si el cliente no tiene órdenes, devuelve `NULL` (mirá el desafío 8).
- **`> ANY`** = "mayor que el mínimo". **`> ALL`** = "mayor que el máximo".
- **Correlacionada:** la subconsulta depende de la fila externa (se evalúa una vez por fila). Siempre usá alias para evitar ambigüedad.

## Quirk de `supplier_ids` (para que no te confunda)

En tu Northwind (y acá), `products.supplier_ids` es una columna de **texto** (porque en el original puede guardar varios ids separados por coma, tipo `"2,3"`). Acá guardamos un solo id por producto. Al comparar `p.supplier_ids = s.id`, MySQL convierte el texto a número y la comparación funciona. Es un quirk heredado del esquema real; tenele respeto cuando lo veas en el trabajo.
