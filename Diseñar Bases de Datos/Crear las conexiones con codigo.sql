/* ============================================================================
   TEMA: Crear base, tabla y alteraciones con código SQL
   ============================================================================
   Objetivo: Reproducir con código lo que la herramienta de modelado arma sola:
   crear la base, entrar en ella, crear la tabla, alterarla y dejar la relación
   lista entre dos tablas.
============================================================================ */


# Que pasa cuando no podemos armar nuestro modelo fisico en herramientas como MySQL Workbench

# La herramienta arma el script que hace todo, si no, se tiene que aprender los comandos de pogramacion

/*
   La herramienta hace las dos cosas juntas: arma el script y después lo
   ejecuta contra el servidor. El script es la pieza que queda, y por eso
   conviene mirarlo: se puede revisar, guardar junto al proyecto y volver a
   correr.

   Sin la herramienta delante, esa tarea queda toda del lado del código. Hacen
   falta las sentencias de definición (DDL) y el orden del script pasa a ser
   parte de su corrección: la base tiene que existir antes de seleccionarla, la
   tabla antes de alterarla, y la tabla referenciada antes que la tabla que la
   referencia.
*/

-- ============================================================================
-- 1. CREAR LA BASE DE DATOS Y SELECCIONARLA
-- ============================================================================
#CREATE DATABASE: Utilizado para crear una nueva base de datos o esquema

CREATE DATABASE IF NOT EXISTS esquema_con_codigo;

/*
   CREATE DATABASE crea el esquema vacío. IF NOT EXISTS lo vuelve repetible: si
   el esquema ya existe, la sentencia no falla y el script puede correrse de
   nuevo sin cortarse en la primera línea. CREATE SCHEMA es sinónimo exacto.

   USE no crea nada: marca cuál es la base activa de esta sesión. Sin esa línea,
   cada tabla tendría que nombrarse con el prefijo de la base
   (esquema_con_codigo.clientes). Y como es una instrucción de sesión, no queda
   guardada: hay que volver a emitirla en el próximo script.
*/

USE esquema_con_codigo;

-- ============================================================================
-- 2. CREAR LA TABLA CON CREATE TABLE
-- ============================================================================
#CREATE TABLE: Utilizado para crear una nueva tabla dentro de una base de datos

/*
   Tres columnas y dos restricciones:

   - cliente_id INT PRIMARY KEY AUTO_INCREMENT: la clave primaria identifica la
     fila, y AUTO_INCREMENT deja que el número lo asigne el motor. Por eso no
     se escribe en el INSERT.
   - nombre VARCHAR(30) NOT NULL: obligatorio, con un máximo de 30 caracteres.
     Ese 30 es un límite de diseño: en modo estricto, un dato más largo hace
     fallar la sentencia en vez de recortarse solo.
   - email VARCHAR(100) NOT NULL UNIQUE: obligatorio y sin repetidos. UNIQUE
     crea un índice, y ese índice es lo que hace rápida la comprobación.

   Ojo: esta es la definición inicial, no la final. La sección siguiente cambia
   tres cosas sobre esta tabla. Después de correr el script completo, clientes
   ya no tiene email.
*/
CREATE TABLE IF NOT EXISTS clientes(
	cliente_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE);

-- ============================================================================
-- 3. ALTERAR LA TABLA EXISTENTE CON ALTER TABLE
-- ============================================================================
#ALTER TABLE: Utilizado para agregar, eliminar o modificar columnas en tabla existente

/*
   Una sola sentencia aplica tres cambios sobre la tabla existente:

   - ADD ciudad VARCHAR(50) NOT NULL: agrega la columna al final. NOT NULL exige
     que haya un valor, pero no prohíbe el texto vacío: '' es un valor válido y
     pasa la restricción. Si la ciudad fuera obligatoria de verdad, haría falta
     además un CHECK o validarlo en la aplicación. En una tabla con filas, el
     motor completa las existentes con el valor implícito del tipo (la cadena
     vacía para un VARCHAR); acá la tabla se crea vacía en el mismo script,
     así que cada fila nueva tiene que traer el dato.

   - MODIFY COLUMN nombre VARCHAR(80) DEFAULT ' ': MODIFY define la columna de
     nuevo desde cero, no le aplica un parche encima. Por eso se pierde el
     NOT NULL que tenía en el CREATE TABLE: la columna pasa a admitir NULL y su
     valor por defecto pasa a ser un espacio. El largo sube de 30 a 80.
     Si la intención era solo alargar el VARCHAR, el NOT NULL hay que volver a
     escribirlo dentro del mismo MODIFY.

   - DROP email: elimina la columna y su índice UNIQUE. Los datos que hubiera en
     esa columna se van con ella, y la sentencia no avisa. Por eso un DROP se
     decide antes de correrlo y, con datos reales, se prueba sobre una copia.
*/
ALTER TABLE clientes
	ADD ciudad VARCHAR(50) NOT NULL,
	MODIFY COLUMN nombre VARCHAR(80) DEFAULT ' ',
	DROP email;

-- ============================================================================
-- 4. CREAR LA TABLA QUE REFERENCIA A LA ANTERIOR
-- ============================================================================

/*
   compras es la tabla que referencia a clientes, así que el orden no es
   opcional: clientes tiene que existir antes.

   - La llave foránea se declara con FOREIGN KEY ... (cliente_id) REFERENCES
     clientes (cliente_id) y crea un índice en compras sobre cliente_id. La
     columna referenciada tiene que estar indexada, y acá lo está porque
     cliente_id es la clave primaria de clientes. El nombre que sigue a
     FOREIGN KEY bautiza la restricción y el índice que el motor crea en esta
     tabla.
   - ON UPDATE CASCADE y ON DELETE NO ACTION deciden qué pasa con las compras
     cuando cambia o desaparece el cliente. Con NO ACTION, borrar un cliente con
     compras cargadas falla en lugar de dejar filas huérfanas. Es la protección
     funcionando.
   - total INT NOT NULL guarda el monto en unidades enteras. Un INT no admite
     decimales: para dinero con centavos, el tipo indicado es DECIMAL (por
     ejemplo, DECIMAL(10, 2)), que guarda el valor exacto. Es una decisión de
     tipo, no un error de la sentencia.
*/
CREATE TABLE IF NOT EXISTS compras(
	compra_id INT PRIMARY KEY AUTO_INCREMENT,
	cliente_id INT NOT NULL,
	total INT NOT NULL,
	FOREIGN KEY fk_clientes_compras (cliente_id)
	REFERENCES clientes (cliente_id) 
		ON UPDATE CASCADE
		ON DELETE NO ACTION );


/* ============================================================================
   DDL EN PRODUCCIÓN: CAMBIAR EL ESQUEMA CON DATOS DENTRO
   ----------------------------------------------------------------------------
   - El orden del script es parte de su corrección: la base antes del USE, la
     tabla antes del ALTER, clientes antes de compras.
   - IF NOT EXISTS hace repetible la creación de la base y de la tabla: correr
     el script dos veces no falla en esas dos líneas. El ALTER TABLE no es
     repetible: la segunda vuelta choca con que ciudad ya existe y email ya no
     está.
   - En MySQL 8.0 el ALTER TABLE es atómico: si una cláusula falla, no se aplica
     ninguna. La tabla no queda a medio cambiar.
   - Antes de tocar una tabla con datos reales, respaldo y, si se puede, una
     copia. Un DROP COLUMN se lleva los datos sin preguntar, y un MODIFY COLUMN
     puede recortar lo que no entre en el tipo nuevo.
   - La definición final de clientes es la que queda después del ALTER, no la
     del CREATE TABLE. Un script se lee hasta el final antes de sacar
     conclusiones sobre cómo quedó el esquema.
   - El script de definición se versiona junto al proyecto, un archivo por
     cambio de esquema: así queda registrado en qué orden se aplicaron los
     cambios y qué había antes.

   ----------------------------------------------------------------------------
   NIVEL PRO: ALTER TABLE INSTANTÁNEO (MySQL 8.0, lo que el curso no cubre)
   ----------------------------------------------------------------------------
   Cambiar el esquema de una tabla grande no siempre obliga a reescribirla.

   - Desde MySQL 8.0.12, ADD COLUMN al final de la tabla puede resolverse como
     una operación INSTANT: el motor cambia solo el metadato, sin reconstruir la
     tabla ni sus índices. En una tabla de millones de filas es la diferencia
     entre un segundo y una ventana de mantenimiento.
   - Se puede pedir de forma explícita, y si el motor no puede cumplirlo, la
     sentencia falla en vez de elegir en silencio el camino más caro:
     -- Estructura ilustrativa (ajusta la columna y el tipo):
     -- ALTER TABLE compras ADD COLUMN <columna> <tipo> NOT NULL,
     --     ALGORITHM=INSTANT;
   - MODIFY COLUMN y DROP COLUMN son otro caso: suelen obligar a reestructurar
     la tabla y sus índices. El costo crece con las filas, así que se planifican.
   - La versión manda: la opción INSTANT para ADD COLUMN aparece en MySQL 8.0.12
     y se fue ampliando en versiones posteriores. Conviene probar el ALTER sobre
     una copia antes de correrlo en producción.
============================================================================ */
