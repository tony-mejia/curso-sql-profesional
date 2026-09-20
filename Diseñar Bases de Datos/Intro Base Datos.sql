/* ============================================================================
   TEMA: Diseñar Bases de Datos — De Qué le Sirve a un Analista
   ============================================================================
   Objetivo: Entender de dónde salen las bases de datos que consultas a
   diario, qué se decide antes de crear la primera tabla y por qué un diseño
   imperfecto igual sirve.
============================================================================ */

-- ============================================================================
-- 1. ¿POR QUÉ LE SIRVE ESTO A UN ANALISTA?
-- ============================================================================
# Como analistas de datos muy probable no es necesario diseñar bases de datos pero es bueno saber de ellas para relaizar mejores consultas o hasta para un emprendimiento personal o dentro de una empresa

/*
   Tres motivos concretos, todos dentro de tu propia línea:

   - Mejores consultas: si sabes por qué una tabla está separada en dos, el
     JOIN deja de ser adivinanza.
   - Bases heredadas: casi todas las que vas a consultar las diseñó otra
     persona, y entender un modelo ajeno es una habilidad en sí misma.
   - Emprendimiento propio: es el caso que mencionas tú mismo.

   Con una aclaración importante: que un analista necesite ENTENDER el diseño
   no significa que tenga que DISEÑARLO. Son responsabilidades distintas y en
   un equipo grande las suelen hacer personas distintas.
*/

# La base de datos debe adecuarse a las necesodades actuales de la empresa 

/*
   La palabra que carga todo el peso es 'actuales'. Las necesidades de una
   empresa cambian, y la base de datos las sigue: por eso esto no es un
   trabajo que se termina, es un trabajo que se mantiene.
*/
# No hay base de datos perfecta
# Ningun diseño de base de datos es perfecto en la primer version 

/*
   Estas dos líneas van en serio, no son una frase motivacional: un modelo de
   la primera versión es un borrador que ya está funcionando con datos reales
   adentro. Se usa, y recién con el uso se ve qué le falta.

   Lo único que no se perdona es un diseño que impide crecer: el resto se
   corrige sobre la marcha.
*/

-- ============================================================================
-- 2. EL PROCESO, ANTES DE TOCAR EL MOTOR
-- ============================================================================
/*
El proceso de diseñar una base de datos
1. Entender el negocio (sus necesidades, sus caracteristicas)
2. Hablar con los Stakeholders (Directivos, analistas y capturistas)

Las bases de datos de dividen en 3 fases de creacion:
1. Modelo conceptul: Cuales van a ser las tablas que van a existir y como van a interactuar entre ellas 
2. Modelo logico: Definir cuales van a ser los campos y las variables de esos campos, tipos de datos 
3. Modelo fisico: Cuando vas a empezar a armar el sistema
* /
*/

/*
   CORRECCIÓN — y esta sí es un error real, no una mala interpretación:

   El comentario de arriba se cierra con '* /', con un espacio entre el
   asterisco y la barra. MySQL no acepta eso como cierre: para el motor ese
   comentario queda abierto.

   Hasta hoy no rompía nada porque era la última línea del archivo. Pero todo
   lo que se agregue debajo cae dentro del comentario y no se ejecuta nunca.

   La línea original queda tal cual la escribiste, sin tocar. El cierre real
   es el que agregué en su propia línea, justo arriba de este bloque: un
   asterisco pegado a una barra.
*/

/*
   Por qué los dos pasos previos no son burocracia:

   - 'Entender el negocio' no es leer un manual: es descubrir qué preguntas
     tiene que poder responder la base de datos. Primero las preguntas,
     después la estructura: al revés se diseña para nadie.
   - 'Hablar con los Stakeholders' son tres públicos con intereses distintos:
     Directivos (qué necesitan decidir), analistas (qué necesitan cruzar) y
     capturistas (quién carga los datos todos los días). El capturista suele
     detectar antes que nadie cuándo un campo está mal pensado, porque lo
     sufre en cada carga.
*/

-- ============================================================================
-- 3. LAS 3 FASES DE CREACIÓN
-- ============================================================================
/*
   Las tres fases son el mismo diseño contado con distinto nivel de detalle:
   cada una traduce a la anterior y agrega decisiones más concretas.

   - Modelo conceptual: el del negocio, sin tecnología. Se decide QUÉ existe
     (las tablas que van a existir) y CÓMO interactúan entre ellas.
   - Modelo lógico: se definen los atributos de cada entidad, las llaves
     primarias y foráneas, y los tipos de dato. Todavía es agnóstico al motor.
   - Modelo físico: ya es cosa del motor. Las entidades pasan a llamarse
     tablas y los atributos, columnas.

   La secuencia importa: un error en la fase 1 se arrastra a las tres
   siguientes. En un borrador cuesta un dibujo; con datos en producción cuesta
   una migración con la base andando.

   Cada fase tiene su propio apunte en esta carpeta: 'Modelo Conceptual.sql',
   'Modelo Logico.sql' y 'ModeloFisico.sql'.
*/

-- ============================================================================
-- 4. NIVEL PRO: LEER UNA BASE QUE NO DISEÑASTE (Reverse Engineer)
-- ============================================================================
/*
   El curso enseña el camino normal: conceptual -> lógico -> físico. En el
   trabajo real te toca muchas veces el camino inverso: llegas a una base con
   cientos de tablas y hay que entenderla sin que nadie te explique nada.

   Para eso existe Reverse Engineer de MySQL Workbench: se conecta a una base
   existente y reconstruye el diagrama a partir de las tablas. Eso te devuelve
   el modelo que nadie documentó.

   Ojo con lo que hace y lo que no: no adivina el diseño original,
   reconstruye las relaciones a partir de las llaves foráneas declaradas. Si
   la base no tiene foráneas, el diagrama sale incompleto, y esa ausencia ya
   es información: te dice que la integridad se está cuidando por otro medio.

   Es la misma herramienta que Forward Engineer leída en la otra dirección:
   una pasa del modelo a las tablas, la otra de las tablas al modelo.
*/

/* ============================================================================
   LO QUE NINGUNA DE LAS 3 FASES CUBRE (y se paga igual)
   ----------------------------------------------------------------------------
   - El costo del cambio no aparece en ningún apunte: renombrar una columna en
     el modelo físico ya obliga a migrar datos y a tocar vistas, reportes y
     procesos que la usaban. Cuanto más tarde el cambio, más caro sale.
   - Ninguna fase te dice qué datos NO guardar. Guardar todo 'por si acaso'
     también es una decisión de diseño, y de las caras.
   - Un analista que entiende el modelo escribe bien el JOIN de una; uno que no,
     lo escribe por prueba y error hasta que le cierra el número.
============================================================================ */
