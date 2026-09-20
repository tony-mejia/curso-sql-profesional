/* ============================================================================
   TEMA: Modelo Conceptual y UML
   ============================================================================
   Objetivo: Entender qué se decide en la fase conceptual, qué aporta UML como
   lenguaje de modelado y por qué esta fase es la más barata de corregir y la
   más cara de equivocar.
============================================================================ */

# Ejemplo practico de un negocio de venta de escritorios

/*
   El apunte trabaja sobre un caso concreto: un negocio que vende escritorios.
   En la fase conceptual ese caso se describe sin pensar todavía en el motor ni
   en los tipos de dato.
*/

/*
 Para este proceso se usa UML
 UML por sus siglas en ingles Unifed Modelling Language
 Lenguaje de modelado cuyo objetivo es estandarizar el diseño de un sistema, puede ser aplicado a las bases de datos*/

/*
   Tres precisiones sobre UML, todas alrededor de tu misma idea:

   - El nombre oficial del estándar es 'Unified Modeling Language' (en inglés:
     'unified' = unificado, 'modeling' = modelado).
   - UML es un lenguaje de modelado general: sirve para describir procesos,
     actores y clases de un sistema completo. Lo que se aplica a una base de
     datos es una parte suya, el diagrama de clases, que se parece mucho a un
     diagrama entidad-relación.
   - 'Estandarizar' es la razón de ser de UML: si dos personas modelan lo mismo
     con la misma notación, los dibujos se entienden entre sí. Eso vale igual
     para la base de datos.

   Ojo con una distinción que en la práctica se mezcla mucho: el diagrama EER
   de MySQL Workbench NO es UML, es una notación propia de bases de datos.
   Cumple el mismo papel (dibujar el modelo antes de crearlo), pero no es el
   estándar de UML.
*/

# Nosotos como analistas podemos aplicarlo pero de manera mas simple

/*
   'Más simple' es la parte importante de tu comentario: no hace falta dominar
   todo UML. Para una base de datos alcanza con identificar las entidades del
   negocio, sus atributos y cómo se relacionan. El resto de UML queda para
   quien modela el software completo.
*/

# ¿Que maneras hay de utilzar UML para bases de datos? Puedes crear tus bases de datos relacionales, bases de datos en esquema estrella 


/*
   Los dos usos que mencionas responden a objetivos distintos:

   - Base de datos relacional: cada dato vive en un solo lugar y las tablas se
     conectan con llaves. Sobre esto va todo el resto del curso.
   - Esquema estrella: una tabla central (los hechos) rodeada de tablas más
     chicas (las dimensiones), con datos repetidos a propósito para leer
     rápido. Es el diseño típico de un almacén de datos y de las herramientas
     de BI: menos JOINs, más velocidad de consulta.

   Ninguno de los dos es 'el correcto'. Se elige según lo que predomine: si se
   escribe mucho y hay que proteger la consistencia, relacional; si se lee
   mucho y se agrupa por categorías, estrella.
*/

/*
   Lo que este apunte deja abierto (y conviene completar): el ejemplo de la
   venta de escritorios quedó enunciado, pero no llegaste a listar sus
   entidades ni sus relaciones. No las agrego yo porque serían invento mío y no
   tu material; es el ejercicio que falta hacer.
*/

/* ============================================================================
   EL MODELO CONCEPTUAL ES EL MÁS BARATO Y EL MÁS CARO A LA VEZ
   ----------------------------------------------------------------------------
   - Es el más barato de corregir: cambiar un dibujo cuesta una conversación.
     Corregir ese mismo error en el modelo físico ya cuesta migrar datos.
   - Es el más caro de equivocar: si una entidad del negocio quedó afuera, en
     las fases siguientes no se nota. Se nota meses después, cuando falta un
     dato que nunca se guardó.
   - UML estandariza la notación, no las decisiones: dos personas pueden usar
     el mismo diagrama y modelar negocios distintos.
   - El esquema estrella demuestra que 'normalizado' y 'bien diseñado' dependen
     del objetivo: el mismo negocio se modela distinto para escribir que para
     analizar.
============================================================================ */
