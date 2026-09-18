# Molde verificado — evidencia

Medido sobre los últimos 15 commits del repo (2026-08-30 a 2026-09-09).

## Qué es fijo y qué es variable

| Elemento | Fijo / variable | Medición |
| --- | --- | --- |
| Encabezado `TEMA:` | Fijo | 15/15 |
| Ancho del separador | Fijo | 79 caracteres (76 signos `=`) |
| Tercer renglón del encabezado | **Variable** | 10 con `Objetivo:`; 5 con explicación directa o la nota cruda del alumno |
| Bloques `/* */` didácticos | Fijo | 15/15 |
| Comentario entre cláusulas | Frecuente | `Eventos Trigger/Creacion de Triggers.sql`, `Eventos.sql`, `Procesos almacenados/Variables.sql`, `Funciones.sql` |
| Comentario al final de la línea de SQL | Puntual | `Eventos Trigger/Triggers como Auditoria.sql:21` |
| Comentario dentro del SELECT, entre columnas | Puntual | `Procesos almacenados/Funciones.sql:81` |
| Separadores `-- n. TÍTULO` | Solo si hay pasos | Eventos, Modificar y Borrar Triggers, Triggers como Auditoria, Funciones, Variables |
| Bloque de cierre | Existe siempre; el título es variable | 15/15 |
| Indentación | Mixta (tabs + espacios) | No se corrige |

## Los typos que sobreviven (prueba de que el texto propio no se toca)

`Conjutnto`, `columanas`, `sognifica`, `registor`, `datros`, `tigger`, `Ejmeplo`, `unicamente`.

Verificado con `git log -S`: cada línea se introdujo en un solo commit y nunca se modificó.

## Títulos del bloque de cierre ya usados

| Título | Cuántos |
| --- | --- |
| `TIPS PRO & TRUCOS DE PRODUCCIÓN` | 7 (lote de septiembre) |
| `DATOS IMPORTANTES PARA EL FUTURO` | 4 (lote de agosto) |
| `EL PODER DE 'NEW' Y 'OLD' (Apunte avanzado)` | 1 |
| `APUNTE AVANZADO / NIVEL PRO (Mundo Real & Millones de Filas)` | 1 |
| `NIVEL PRO (Rendimiento)` | 1 |
| `DIFERENCIA CLAVE PARA EL FUTURO (Variables '@' vs 'DECLARE')` | 1 |

## Las dos decisiones del autor

1. **El título del bloque de cierre se adapta al tema.** No se usa siempre `TIPS PRO & TRUCOS DE PRODUCCIÓN`.
2. **La sección NIVEL PRO con consulta o alternativa moderna depende del tema.** No está limitada a CTE ni Window Functions: puede ser cualquier técnica moderna pertinente. Se agrega cuando el tema lo amerita y hay que decir cuál se agregó y por qué.

Precedentes de NIVEL PRO con consulta alternativa: `Queries complejos/Consultas dentro de From.sql:56` (CTE) y `Queries complejos/Consultas dentro del Select.sql:39` (Window Functions).

## Lista de NO inventar

- No tocar líneas propias ni typos.
- No convertir finales de línea CRLF a LF: es una modificación del archivo original. Medido sobre los 27 pendientes: 23 en CRLF y solo 4 en LF (`Conexion via ODBC.sql`, `Llaves Foraneas.sql`, `Restricciones en Foreign Key.sql`, `Reverse Engineer.sql`).
- No asumir que el archivo termina en salto de línea: 19 de los 27 no lo tienen. Agregar contenido debajo obliga a terminar esa última línea, y es la ÚNICA diferencia inevitable. Hay que reportarla, nunca esconderla.
- No reescribir un archivo sin respaldo: los pendientes están sin commitear, así que git no los puede recuperar.
- No fijar el título del cierre: se adapta al tema.
- No forzar `Objetivo:` en el encabezado.
- No usar tablas ni columnas que no aparezcan en el material del alumno.
- No presentar datos de ejemplo como si fueran reales.
- No reformatear la indentación.
- No inventar secciones si el apunte no tiene pasos.
- No meter NIVEL PRO donde el tema no lo pide.
- No marcar como error una nota que solo es fácil de malinterpretar: aclárala en un comentario aparte.

## Estado del repo al crear esta skill

104 archivos `.sql`: 35 con encabezado `TEMA:`, 12 con `Objetivo:`. Sin plantilla todavía: `Trabajar con una sola tabla/` (11), `Diseñar Bases de Datos/` (16, sin commitear), `Trabajar con Varias Tablas/` (9), `Trabajar con Datos/` (8), `Indexing/` (7, sin commitear), `Resumir Datos/` (4), `Asegurar bases de Datos/` (3, sin commitear), `Estructuras JSON/` (3).

Candidato crudo listo para practicar: `Queries complejos/Subconsultas.sql`.

## Verificación usada en el primer apunte mejorado con esta skill

`Indexing/Mostrar y Eliminar Indices-01.sql` (10 líneas → 89). Comprobado: las 6 líneas propias presentes byte a byte, 0 líneas de contenido borradas, 11 separadores a 79 caracteres, y CRLF preservado (el archivo original era el único de los 27 pendientes en CRLF).

Comandos útiles:

```bash
file "$F"                     # finales de línea y encoding
awk 'length($0)>60' "$F"       # ancho de los separadores (deben ser 79)
tail -c 1 "$F" | od -c         # ¿termina en salto de línea?
```

**Cuidado al verificar**: un bucle `while IFS= read -r line; do ... done` SALTA la última línea cuando el archivo no termina en salto de línea (el `read` devuelve fallo al llegar al EOF aunque asigne la variable). Hay que comprobar esa última línea aparte, con `sed 's/\r$//' "$F" | tail -1`.

**Trampa peor**: detectar si un archivo es CRLF mirando sus últimos 2 bytes (`tail -c 2`) da FALSO NEGATIVO cuando el archivo no termina en salto de línea, que es el caso de 19 de los 27 pendientes. Eso deja el archivo convertido a LF sin avisar. Para saber el tipo real, siempre `file -b "$F"`.

**Todo esto ya está automatizado**: `assets/verifica-apunte.sh "<ruta>" [respaldo]` hace las cinco comprobaciones (placeholders, finales de línea, líneas propias byte a byte, aditividad, separadoras a 79) y avisa cuando el original no terminaba en salto de línea. Usarlo en vez de repetir los comandos a mano.
Para probar que el cambio es puramente aditivo:

```bash
diff --unchanged-line-format= --old-line-format='-|%L' --new-line-format= \
  <(sed 's/\r$//' "$BACKUP") <(sed 's/\r$//' "$F")
```

## Convención de commits

Formato: `docs(<scope>): <descripción>`. Conventional Commits, **sin cuerpo**, **un archivo por commit**.

| Parte | Regla |
| --- | --- |
| `docs` | Siempre. Es un apunte, no código. |
| `<scope>` | La carpeta o tema, en minúsculas: `modelado`, `transacciones`, `concurrencia`, `bi`, `indexing` |
| `<descripción>` | Frase nominal en minúsculas que resume el TEMA del archivo, no la lista de cambios |
| Cuerpo | Ninguno. Los commits del repo no llevan cuerpo |

Ejemplos reales del repo:

```
docs(modelado): tipos de claves primarias, foraneas y compuestas
docs(transacciones): principios acid, flujo de ejecución y notas de motor a nivel producción
docs(concurrencia): control de updates y bloqueos por fila
docs(indexing): mostrar y eliminar indices con SHOW INDEX y DROP INDEX
docs(indexing): indices compuestos y regla del prefijo izquierdo
```

Los acentos son inconsistentes en el historial (`foraneas` sin, `diseño` con). No es un criterio: no los agregues ni los quites por tu cuenta.

**Precaución al commitear**: hay muchos otros archivos sin commitear que NO deben entrar. Siempre:

```bash
git add -- "ruta/con espacios.sql"
git diff --cached --name-only     # debe listar UN solo archivo
git commit -q -m 'docs(scope): descripción'
```

Con `core.autocrlf=true` git normaliza CRLF→LF al commitear, pero el working tree conserva CRLF. Eso es correcto, no lo "arregles".
