/* ============================================================================
   TEMA: Conexión de MySQL a Excel por ODBC
   ============================================================================
   Objetivo: Conectar una planilla de Excel con la base: qué pieza hay que
   instalar para que esa conexión exista y qué pide MySQL del otro lado.
============================================================================ */

# Se tiene que descargar el complemento para conectar MySQL a Excel

/*
   El complemento tiene nombre: es el driver ODBC de MySQL (Connector/ODBC).
   ODBC es la interfaz estándar por la que un programa de Windows habla con una
   base que no es suya, y Excel no trae el de MySQL de fábrica: se instala aparte.

   El DSN (Data Source Name) es donde quedan guardados el host, el puerto 3306,
   la base y el usuario. No es un requisito general: Connector/ODBC también
   admite conexiones sin DSN, donde todos esos datos (driver, servidor, puerto,
   base y usuario) viajan en la cadena de conexión. Para el asistente de Excel,
   en cambio, el DSN es el camino normal: con el DSN armado, Excel ve la base en
   Datos -> Obtener datos -> Desde otras fuentes -> Desde ODBC.

   Dos motivos explican casi todos los fracasos: el driver tiene que ser de la
   misma arquitectura que Excel (64 bits con 64 bits), y la cuenta de MySQL
   necesita poder conectarse desde ese host y tener SELECT sobre la base.
*/

/* ============================================================================
   ODBC EN EL MUNDO REAL: DRIVER, DSN Y PERMISOS
   ----------------------------------------------------------------------------
   - El driver no vive en la base: se instala en cada máquina donde corre Excel.
   - Si no aparece ningún driver en el asistente, es arquitectura: Excel de 64
     bits solo ve drivers de 64 bits.
   - El DSN no es la conexión, es la receta; un DSN de sistema lo pueden usar
     todos los usuarios de la máquina.
   - Nunca se conecta Excel con root ni con la cuenta de la aplicación: para
     leer y reportar, una cuenta de solo lectura (ver 'Crear Usuario.sql' y
     'Administracion de privilegios y usuarios.sql', en esta misma carpeta).

   ----------------------------------------------------------------------------
   NIVEL PRO: POWER QUERY, EL CAMINO ACTUAL EN EXCEL (lo que el curso no cubre)
   ----------------------------------------------------------------------------
   El asistente clásico sigue funcionando, pero hoy Excel importa datos con
   Power Query, que puede usar el mismo driver y el mismo DSN. La diferencia es
   lo que queda guardado: la consulta vive dentro del libro, se puede editar y
   se refresca con un botón, en lugar de rearmarse cada vez. Con tablas grandes
   conviene traer solo las columnas y las filas que la planilla necesita.
============================================================================ */
