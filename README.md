# Curso SQL

Apunte personal del curso de SQL avanzado sobre MySQL. Cada archivo es la nota
de un tema: primero la escribo a mano mientras avanzo en el curso, después la
mejoro con IA, y recién ahí la commiteo.

El objetivo no es tener documentación perfecta, es tener un apunte que dentro de
seis meses reconozca como mío.

## El molde de cada apunte

Todas las notas mejoradas siguen la misma estructura:

```
/* ============================================================================
   TEMA: <el tema, en pocas palabras>
   ============================================================================
   <de qué va, en 1-3 líneas>
============================================================================ */

-- ============================================================================
-- 1. <SECCIÓN, EN MAYÚSCULAS>
-- ============================================================================
# mi apunte, tal cual lo escribí
/* explicación: qué pasa por dentro, por qué funciona o por qué falla */
<el SQL>

/* ============================================================================
   <BLOQUE DE CIERRE, CON TÍTULO ADAPTADO AL TEMA>
   ----------------------------------------------------------------------------
   - tips de producción
   - errores comunes
   - técnica moderna que el curso no cubre, si el tema lo pide
============================================================================ */
```

**La regla que no se rompe: mis líneas originales no se tocan.** Ni los typos,
ni las frases a medias. La mejora es siempre agregar alrededor, nunca editar por
encima. Los typos que quedan a la vista son la prueba de que se respetó.

El molde completo, con las mediciones que lo respaldan y la lista de lo que no
se debe inventar, está en
[`references/molde-verificado.md`](.pi/skills/mejorar-apunte/references/molde-verificado.md).

## Cómo se mejora un apunte

Hay una skill de Pi que hace exactamente esto:

```
/skill:mejorar-apunte
```

O simplemente pidiéndolo en lenguaje natural: *"mejora los apuntes de Indexing"*,
*"aplica la plantilla a este apunte"*.

Vive en [`.pi/skills/mejorar-apunte/`](.pi/skills/mejorar-apunte/) y trae:

| Archivo | Para qué |
| --- | --- |
| `SKILL.md` | El contrato: qué agrega, qué no toca, qué decide según el tema |
| `assets/plantilla.sql` | El esqueleto listo para copiar |
| `assets/verifica-apunte.sh` | Comprueba que la mejora haya sido puramente aditiva |
| `references/molde-verificado.md` | La evidencia medida y la lista de lo que no se inventa |

El verificador es el que sostiene la regla: revisa que cada línea propia siga
presente byte a byte, que no se haya borrado contenido, que los separadores
midan 79 caracteres y que los finales de línea no hayan cambiado.

```bash
bash .pi/skills/mejorar-apunte/assets/verifica-apunte.sh "Indexing/Indexing_02.sql"
```

## Estado

104 apuntes en total; **42 ya tienen el molde**.

| Carpeta | Con molde | Total |
| --- | ---: | ---: |
| `Indexing` | 7 | 7 |
| `Procesos almacenados` | 8 | 8 |
| `Funciones esenciales SQL` | 6 | 6 |
| `Eventos Trigger` | 5 | 5 |
| `Modelado de datos` | 5 | 5 |
| `Transacciones y Concurrencia` | 3 | 3 |
| `Vistas` | 3 | 3 |
| `Queries complejos` | 5 | 13 |
| `Diseñar Bases de Datos` | 0 | 16 |
| `Trabajar con una sola tabla` | 0 | 11 |
| `Trabajar con Varias Tablas` | 0 | 9 |
| `Trabajar con Datos` | 0 | 8 |
| `Resumir Datos` | 0 | 4 |
| `Asegurar bases de Datos` | 0 | 3 |
| `Estructuras JSON` | 0 | 3 |

**En cola (escritos pero sin commitear): 20.** Son los siguientes a mejorar:

- `Asegurar bases de Datos` — 3
- `Diseñar Bases de Datos` — 16
- `Queries complejos/Ejercicio - Queries complejos.sql` — 1

**Pendientes de la fase temprana: 42**, ya commiteados pero escritos antes de que
existiera el molde (todas las carpetas de "Trabajar con...", "Resumir Datos" y
parte de "Queries complejos").

## Convención de commits

[Conventional Commits](https://www.conventionalcommits.org/), **un archivo por
commit** y **sin cuerpo**:

```
docs(indexing): condicion OR sin indice y reescritura con UNION
docs(modelado): relacion 1 a 1 y consideraciones de diseño
docs(transacciones): principios acid, flujo de ejecución y notas de motor a nivel producción
```

- `docs(<carpeta>): <tema>` para un apunte. El scope es la carpeta, en minúsculas.
- `chore: ...` para infraestructura (gitignore, skills, herramientas).

Los apuntes se commitean de a uno para que el historial se pueda revisar. Antes
de cada commit conviene confirmar que entra un solo archivo:

```bash
git add -- "ruta/con espacios.sql"
git diff --cached --name-only     # debe listar UN solo archivo
```

---

El material del curso (PDF, base Northwind, respuestas de los ejercicios) no se
versiona: está en `Recursos/` y en el `.gitignore`.
