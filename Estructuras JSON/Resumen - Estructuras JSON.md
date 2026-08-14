# Resumen — Estructuras JSON (Capítulo)

> La idea central: **JSON te deja guardar datos SEMI-ESTRUCTURADOS en una sola celda.** En vez de crear varias tablas o columnas rígidas, metés un objeto JSON con toda la info y después la extraés cuando la necesitás.

Es súper común hoy: APIs, configuraciones, datos flexibles de productos, etc.

---

## A) ¿Qué es JSON y cómo se escribe?

JSON = **JavaScript Object Notation**. Es un formato de texto con dos estructuras básicas:

```json
{ "dimension": [5, 10, 20], "productos": ["pizza", "burrito"], "cantidad": 2 }
```

- **Objeto** `{ }` → pares de `"clave": valor`.
- **Array** `[ ]` → lista de valores.
- Los valores pueden ser: número, texto, booleano, otro objeto, o un array.

### Guardar JSON en una columna

```sql
UPDATE productos
SET caracteristicas = '{"dimension":[5,10,20],"productos":["pizza","burrito"],"cantidad":2}'
WHERE productos_id = 8;
```

- La columna `caracteristicas` guarda el JSON como texto (en MySQL conviene que sea tipo `JSON` para validarlo y operarlo mejor).
- **Caso real:** un producto con "atributos" variables (dimensiones, ingredientes incluidos, cantidad) que no querés convertir en 20 columnas fijas.

---

## B) Extraer datos de un JSON — JSON_EXTRACT

`JSON_EXTRACT` extrae un valor del JSON usando una **ruta** (path) que empieza con `$`.

```sql
-- La raíz es $, y entrás con .clave
SELECT productos_id, producto, JSON_EXTRACT(caracteristicas, "$.dimension")
FROM productos;

SELECT productos_id, producto, JSON_EXTRACT(caracteristicas, "$.cantidad")
FROM productos;

SELECT productos_id, producto, JSON_EXTRACT(caracteristicas, "$.productos") AS productos_incluidos
FROM productos;
```

### Cómo funciona el path (`$.clave`)

| Path | Qué extrae |
|---|---|
| `$` | todo el JSON |
| `$.cantidad` | el valor de la clave `cantidad` |
| `$.productos` | el array completo `["pizza","burrito"]` |
| `$.productos[0]` | el PRIMER elemento del array (`"pizza"`) |
| `$.productos[1]` | el segundo elemento |

- Para **arrays** usás índice `[0]`, `[1]`, `[2]`... (empiezan en 0).
- Para **objetos** usás `.clave`.

---

## C) Más funciones de JSON (para completar el capítulo)

Tu lección `Funciones de JSON.sql` quedó vacía, pero el mundo JSON en MySQL es más grande. Las más útiles:

| Función / operador | Qué hace |
|---|---|
| `JSON_EXTRACT(json, path)` | Extrae el valor en el path |
| `json -> path` | Atajo de `JSON_EXTRACT` |
| `json ->> path` | Extrae y **devuelve texto sin comillas** (más cómodo) |
| `JSON_UNQUOTE(...)` | Le quita las comillas a un valor de texto |
| `JSON_OBJECT('a', 1, 'b', 2)` | CREA un objeto JSON |
| `JSON_ARRAY(1, 2, 3)` | CREA un array JSON |
| `JSON_CONTAINS(...)` | Verifica si contiene un valor |

**Caso real del atajo:**
```sql
-- JSON_EXTRACT devuelve "burrito" CON comillas
SELECT JSON_EXTRACT(caracteristicas, "$.productos[1]") FROM productos;

-- ->> devuelve burrito SIN comillas (listo para mostrar)
SELECT caracteristicas ->> "$.productos[1]" FROM productos;
```

---

## El hilo conductor

| Quiero... | Uso |
|---|---|
| Guardar datos flexibles en una celda | columna tipo `JSON` |
| Extraer un valor por su clave | `JSON_EXTRACT(c, "$.clave")` |
| Extraer un elemento de un array | `"$.clave[0]"` |
| Extraer texto sin comillas | `->>` o `JSON_UNQUOTE` |
| Crear un objeto / array | `JSON_OBJECT` / `JSON_ARRAY` |
| Verificar si contiene algo | `JSON_CONTAINS` |

> **Regla mental:** `$` es la raíz del JSON. `$`.clave entra a un objeto; `[n]` entra a un array. JSON es la forma moderna de guardar datos "que no sabés exactamente cómo van a cambiar".
