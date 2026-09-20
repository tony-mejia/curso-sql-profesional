/* ============================================================================
   TEMA: Tercera Forma Normal (3FN) y Dependencia Transitiva
   ============================================================================
   Objetivo: Entender qué es la dependencia transitiva, el nombre que aparece
   en la regla 2 sin explicación, y reconocer que las dos notas del apunte
   describen esa misma regla desde dos lados.
============================================================================ */

/*
 Reglas de la tercera forma normal
 1. Cumplir con la segunda forma normal
 2. No exista dependencia transitiva
 **/

/*
   La regla 2, 'no exista dependencia transitiva', nombra el problema pero no lo
   describe. La dependencia transitiva es esto: la llave primaria X determina la
   columna Y, e Y determina la columna Z. La columna Z termina dependiendo de la
   llave por el camino largo, a través de Y, y no directamente.

   Ejemplo inventado para ilustrar (sin tabla real, solo la idea): en una misma
   tabla se guardan el código postal y la ciudad. La llave identifica la fila y
   el código postal determina la ciudad; la ciudad depende del código postal,
   que no es la llave. Cada fila repite la ciudad, y el día que un código postal
   cambie de ciudad en los datos, las filas quedan en desacuerdo.

   El arreglo es siempre el mismo: sacar a Y y a Z a su propia tabla y dejar en
   esta solamente la referencia.
*/

# No se puede tener una columna de una tabla que dependa de otra columna que no se la clave primaria

# No puedes tener una columna no primaria, dependiendo de otra columna no primaria

/*
   Estas dos líneas son la misma regla dicha dos veces, y las dos describen una
   dependencia transitiva:

   - La primera la cuenta desde la columna que manda: una columna que depende de
     otra que no es la llave primaria.
   - La segunda la cuenta desde la columna que sobra: una columna no primaria
     que depende de otra columna no primaria.

   En los dos casos el patrón es idéntico: entre la llave primaria y la columna
   final hay una parada intermedia. Esa parada intermedia es el problema.
*/

# Lo importante de la normalizacion es eliminar o minimizar redundancias en los datos

/*
   'Eliminar o minimizar redundancias' es el objetivo, pero el motivo real está
   un paso más allá del espacio en disco: el dato repetido puede quedar en
   desacuerdo consigo mismo. Guardar diez veces la ciudad de un código postal
   ocupa poquísimo; el problema es el día que nueve filas se actualizan y una
   no. Desde ese momento la base tiene dos verdades y ninguna consulta puede
   decidir cuál vale.
*/

/* ============================================================================
   3FN NO ES EL FINAL: BCNF Y CUÁNDO PARAR DE NORMALIZAR
   ----------------------------------------------------------------------------
   - BCNF (la forma que aparece en la lista del apunte de 1FN) es más estricta
     que 3FN. La diferencia se ve en tablas con varias llaves candidatas que se
     solapan: casos donde 3FN todavía deja una dependencia donde no corresponde.
   - En la práctica, 3FN es el punto de parada habitual de los sistemas que
     escriben. Subir a BCNF, 4FN o 5FN resuelve casos cada vez más raros y suele
     agregar tablas, así que se aplica cuando el problema aparece, no por
     defecto.
   - Normalizar es una decisión de diseño, no una carrera hacia la forma más
     alta: cada tabla extra es un JOIN más en cada consulta.
   - Para analítica el camino es el opuesto y es deliberado: se desnormaliza en
     un esquema estrella para leer rápido, aceptando la redundancia y su riesgo.
============================================================================ */
