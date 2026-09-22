/* ============================================================================
   TEMA: Crear usuarios con CREATE USER
   ============================================================================
   Objetivo: Crear una cuenta de MySQL entendiendo sus dos mitades, el usuario
   y el host desde donde se conecta, y cómo queda guardada su contraseña.
============================================================================ */

# CREATE USER: Permite crear nuevos usuarios o cuentas  y establecer propiedades de autenticacion

/*
   Exacto, y conviene desarmar la frase: CREATE USER crea la cuenta y define
   cómo se va a autenticar (el plugin con el que verifica la contraseña y sus
   reglas). Crear la cuenta y darle permisos son dos pasos distintos: los
   permisos llegan después, con GRANT.
*/

# Se debe especificar desde donde se tiene que conectar el ususario con '@'

/*
   Es correcto, con un matiz que decide la seguridad de la cuenta: no es
   obligatorio escribirlo, pero sí decidirlo. Si se omite el host, MySQL usa
   '%' y la cuenta queda habilitada desde cualquier máquina.
   -- 'Daniel'@'localhost'   -- solo desde el propio servidor
   -- 'Daniel'@'%'           -- desde cualquier host
   Ojo con un host que no es lo que parece: 'localhost' y '127.0.0.1' son
   cuentas distintas, aunque conecten a la misma máquina.
*/
# Su contraseña

/*
   Se declara con IDENTIFIED BY, y el servidor no guarda esa contraseña: guarda
   un hash (la columna authentication_string de mysql.user). No se puede leer de
   vuelta; si se pierde, se cambia con ALTER USER. Y la contraseña escrita en el
   script convierte al script en material sensible.
*/

CREATE USER Daniel IDENTIFIED BY 'abcd1234';

/*
   Esta sentencia crea la cuenta 'Daniel'@'%' (host omitido, o sea cualquiera)
   con la contraseña 'abcd1234'. El nombre va sin comillas porque es un
   identificador válido; con espacios o guiones habría que citarlo.
   Es el ejemplo del apunte, no una cuenta para producción: una clave real no
   se escribe en claro en un archivo.
*/

/* ============================================================================
   CREAR CUENTAS EN EL MUNDO REAL: HOST, CONTRASEÑA Y PLUGIN
   ----------------------------------------------------------------------------
   - Decidir el host antes de crear la cuenta. '%' es cómodo para probar y
     peligroso en producción: para una aplicación, lo normal es acotarlo al host
     o a la red desde donde se conecta.
   - La contraseña se escribe una sola vez, no se puede leer de vuelta, y el
     script que la tiene en claro es material sensible. Rotarla es
     ALTER USER ... IDENTIFIED BY.
   - Antes de borrar una cuenta, mirar qué privilegios tiene: se van con ella
     (DROP USER).

   ----------------------------------------------------------------------------
   NIVEL PRO: EL PLUGIN DE AUTENTICACIÓN DE MySQL 8.0 (caching_sha2_password)
   ----------------------------------------------------------------------------
   MySQL 8.0 cambió el plugin por defecto: la contraseña ya no se verifica con
   el viejo mysql_native_password sino con caching_sha2_password, más seguro
   pero más exigente con el cliente.
   -- Estructura ilustrativa:
   -- CREATE USER 'Daniel'@'%' IDENTIFIED WITH caching_sha2_password BY '<clave>';
   -- -- Para un conector viejo, como el de Excel por ODBC, se baja el plugin:
   -- ALTER USER 'Daniel'@'%' IDENTIFIED WITH mysql_native_password BY '<clave>';
   El síntoma no es un error de contraseña sino "Authentication plugin
   'caching_sha2_password' cannot be loaded": el conector es viejo, no la clave
   (ver 'Asegurar bases de Datos/Conexion via ODBC.sql'). En MySQL 8.4 el plugin
   viejo ya viene deshabilitado, así que lo correcto es actualizar el conector.
============================================================================ */
