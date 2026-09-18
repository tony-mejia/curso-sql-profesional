/* ============================================================================
   TEMA: Qué Es Indizar y Cuánto Cuesta
   ============================================================================
   Objetivo: Entender por qué un índice acelera las consultas, y asumir el
   precio que se paga por tenerlo.
============================================================================ */

-- ============================================================================
-- 1. LA IDEA (La sección amarilla)
-- ============================================================================
# Indizar va a ayudar a hacer mas rapida la menera de trabajar, mas rapidas las consultas en MySQL

/*
 Antes las personas usaban las seccion amarilla para hacer llamadas
 Si querias llamar a los negocios de pizza tenias que buscar la p, luego p-iz
 Esto era basicamente hacer un indice alfabetico para buscar el negocio que querias*/

/*
   La analogía es exacta, y conviene estirarla un poco porque explica todo
   lo demás:

   - El listado alfabético es una estructura APARTE de la guía. No es la guía
     reordenada: es un índice al lado. Lo mismo hace MySQL, guarda una
     estructura extra y ordenada junto a la tabla.
   - Está ordenado. Por eso pasar de 'p' a 'piz' es bajar por una lista en
     vez de leer la guía página por página. Eso es el B-tree: un árbol
     ordenado que permite descartar porciones enteras de un salto.
   - Y solo sirve si buscas como está ordenado. En la sección amarilla
     buscabas por NOMBRE de negocio. Si alguien te pedía "todos los que
     atienden los domingos", ese índice no te salvaba: había que leer todo.
     Eso es exactamente 'type = ALL' en el EXPLAIN.
*/

-- ============================================================================
-- 2. POR QUÉ CON POCOS DATOS NO SE NOTA
-- ============================================================================
#En una base de datos si pones a la computadora a buscar datos no indizados se va a tardar mucho mas si la pones a buscar datos indizados

/*
   Sí, con un matiz que importa para decidir cuándo crearlo: la diferencia
   aparece con volumen. Con 100 filas, leerlas todas es prácticamente
   instantáneo y el índice no te cambia la vida.
*/
# Cuando se trabaja con miles de datos indizar se vuelce indispensable

/*
   Y "miles" es una forma de decir: la cifra exacta no es el punto. Lo que
   decide es cuántas filas tiene que tocar la consulta comparado con cuántas
   tiene la tabla. Un índice brilla cuando filtra un porcentaje chico.
*/

/* ============================================================================
   EL PRECIO DE INDIZAR (lo que se paga por la velocidad de lectura)
   ----------------------------------------------------------------------------
   - Se lee más rápido, se escribe más lento. Cada INSERT, UPDATE y DELETE
     obliga a mantener los índices al día. Una tabla con muchos índices
     escribe bastante más que una sin ellos.
   - Ocupa disco, aparte del espacio de la tabla, y a veces bastante.
   - Solo sirve para las consultas que usan la columna por la que está
     ordenado. Un índice de más cuesta tanto como uno de menos: paga
     escrituras y no aporta nada.
   - La pregunta correcta antes de crear uno no es "¿acelera esta consulta?",
     sino "¿cuánto cuesta mantenerlo y cuántas consultas se benefician de
     verdad?".
============================================================================ */
