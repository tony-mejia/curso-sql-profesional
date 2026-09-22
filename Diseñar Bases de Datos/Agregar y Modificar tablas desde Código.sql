/* ============================================================================
   TEMA: Crear y modificar tablas desde código (DDL)
   ============================================================================
   Objetivo: Escribir a mano lo que Workbench generaría solo: crear la base,
   crear la tabla y después modificarla sin rehacerla ni perder los datos.
============================================================================ */

# Que pasa cuando no podemos armar nuestro modelo fisico en herramientas como MySQL Workbench

/*
   Pasa que el modelo físico también se puede escribir directamente. Workbench
   está cómodo, pero no siempre está: en un servidor, en un script de despliegue
   o en un entorno donde solo hay cliente de línea de comandos, lo que queda es
   el código. Ese código es DDL, el lenguaje que define estructuras (bases,
   tablas, columnas) en lugar de filas.
*/

# La herramienta arma el script que hace todo, si no, se tiene que aprender los comandos de pogramacion

/*
   Esa es la razón práctica: Workbench genera el script y lo aplica, así que se
   puede usar sin escribir una línea. Aprender los comandos sirve para lo otro:
   revisar lo que la herramienta propone antes de ejecutarlo, y arreglar a mano
   lo que el modelo no cubre. El script de abajo es ese recorrido completo, en
   cuatro pasos.
*/

-- ============================================================================
-- 1. CREAR LA BASE DE DATOS EN CÓDIGO
-- ============================================================================
#CREATE DATABASE: Utilizado para crear una nueva base de datos o esquema

CREATE DATABASE IF NOT EXISTS esquema_con_codigo;

/*
   Crea el esquema donde después viven las tablas. El IF NOT EXISTS es lo que
   permite re-ejecutar el script sin que se caiga: si la base ya existe, la
   sentencia no hace nada. Sin él, MySQL corta con "Can't create database
   'esquema_con_codigo'; database exists".
   Si no se declara charset ni colación, la base hereda los del servidor.
*/

-- ============================================================================
-- 2. SELECCIONARLA PARA TRABAJAR
-- ============================================================================
USE esquema_con_codigo;

/*
   USE no crea ni cambia nada en disco: mueve la conexión a ese esquema. De acá
   en adelante, 'clientes' se resuelve solo. Es el equivalente en código a
   elegir la base en el panel de Workbench, y si se saltea, el CREATE TABLE
   falla con "No database selected".
*/

-- ============================================================================
-- 3. CREAR LA TABLA
-- ============================================================================
#CREATE TABLE: Utilizado para crear una nueva tabla dentro de una base de datos

CREATE TABLE IF NOT EXISTS clientes(
	cliente_id INT PRIMARY KEY AUTO_INCREMENT,
	nombre VARCHAR(30) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE);

/*
   Es el mismo paso que da Forward Engineer cuando baja el modelo, pero escrito
   a mano, con las mismas piezas:
   - cliente_id INT PRIMARY KEY AUTO_INCREMENT: entero, clave primaria y
     autogenerado; es el único campo que no depende del negocio.
   - nombre VARCHAR(30) NOT NULL: texto obligatorio de hasta 30 caracteres.
   - email VARCHAR(100) NOT NULL UNIQUE: obligatorio y no se puede repetir.
   El IF NOT EXISTS se saltea la sentencia entera si la tabla ya existe: la deja
   como estaba, no la corrige. La indentación no le importa al motor; el punto y
   coma final sí.
*/

-- ============================================================================
-- 4. MODIFICAR LA TABLA YA CREADA (ALTER TABLE)
-- ============================================================================
#ALTER TABLE: Utilizado para agregar, eliminar o modificar columnas en tabla existente

ALTER TABLE clientes
	ADD ciudad VARCHAR(50) NOT NULL,
	MODIFY COLUMN nombre VARCHAR(80) DEFAULT ' ',
	DROP email;

/*
   Las tres acciones van en UNA sola sentencia, separadas por comas: es una
   operación de esquema, no tres.
   - ADD ciudad VARCHAR(50) NOT NULL: agrega la columna. En una tabla que ya
     tiene filas, esas filas quedan con el valor por defecto implícito del tipo
     (cadena vacía en un VARCHAR), así que declarar un DEFAULT evita sorpresas.
   - MODIFY COLUMN nombre VARCHAR(80) DEFAULT ' ': cambia el tipo y el default
     de una columna que ya existía. De 30 a 80 es un ensanche y entra sin
     problema. Al revés, acortar la columna solo falla con SQL estricto si
     algún valor existente quedaría truncado; si todos entran en el nuevo
     largo, el cambio pasa aunque el modo estricto esté activo.
   - DROP email: elimina la columna, su contenido y el índice UNIQUE que había
     creado. No hay Ctrl+Z: la columna se va con los datos que tenía adentro.
*/

/* ============================================================================
   DDL EN PRODUCCIÓN: LO QUE NO SE DESHACE CON Ctrl+Z
   ----------------------------------------------------------------------------
   - El script se guarda. Es el mismo DDL que Forward Engineer muestra antes de
     aplicarlo, y tenerlo versionado permite revisarlo y correrlo en otro entorno.
   - IF NOT EXISTS hace el script repetible, pero esconde diferencias: si la
     tabla ya existía con otras columnas, no avisa.
   - Un ALTER TABLE no siempre es gratis: puede reconstruir la tabla entera y
     dejar las escrituras esperando. Con datos en producción, se prueba primero
     sobre una copia.
   - Antes de un DROP COLUMN se mira quién la usa: si una vista, un trigger o una
     consulta la nombra, queda rota.
   - Los prefijos numéricos de las secciones son para leer, no para el motor.

   ----------------------------------------------------------------------------
   NIVEL PRO: ALTER TABLE PESADO SIN VENTANA DE MANTENIMIENTO (Online DDL)
   ----------------------------------------------------------------------------
   Un cambio de esquema puede copiar la tabla entera mientras la bloquea. Desde
   5.6 existe Online DDL, y MySQL 8.0 lleva varios cambios a ALGORITHM=INSTANT:
   solo se toca el metadato y termina en segundos, sin copiar filas.
   -- Estructura ilustrativa:
   -- ALTER TABLE clientes ADD COLUMN <columna> INT, ALGORITHM=INSTANT;
   -- ALTER TABLE clientes ADD COLUMN <columna> INT, ALGORITHM=INPLACE, LOCK=NONE;
   Si el algoritmo pedido no es posible, MySQL corta con el ERROR 1846 en lugar
   de degradar a una copia completa: en producción, eso es lo que se busca. Para
   tablas enormes hay herramientas externas que trabajan sobre una copia
   (pt-online-schema-change, gh-ost).
============================================================================ */
