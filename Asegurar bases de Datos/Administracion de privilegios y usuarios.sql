/* ============================================================================
   TEMA: Administración de usuarios y privilegios (mysql.user)
   ============================================================================
   Objetivo: Ver qué se puede hacer cuando hay que modificar usuarios y cómo
   leer, sin tocar nada, la tabla del sistema donde MySQL guarda las cuentas.
============================================================================ */

# Que podemos hacer si queremos modificar usuarios?

/*
   Modificar un usuario son varias operaciones, y cada una tiene su sentencia:
   CREATE USER (crear la cuenta), ALTER USER (contraseña y propiedades), RENAME
   USER (cambiarla de nombre), GRANT y REVOKE (permisos) y DROP USER (borrarla).
   La nota apunta bien: esto se hace con sentencias, no editando archivos del
   servidor. Un detalle del motor: en MySQL 8.0, GRANT ya no crea la cuenta si
   no existe; primero se crea con CREATE USER.
*/

# Comando mysql.user: Devuelve una tabla con las cuentas de usuario y provilegios 

/*
   La idea es exacta, con un matiz de nombre: mysql.user no es un comando, es
   una tabla del sistema, del esquema 'mysql'. Cada fila es una cuenta, y la
   cuenta completa es el par User + Host: el mismo nombre en 'localhost' y en
   '%' son dos cuentas distintas. Las columnas *_priv (Select_priv, ...) son los
   privilegios globales, y authentication_string guarda el hash de la contraseña,
   nunca la contraseña. Para una cuenta puntual hay una lectura más cómoda:
   -- SHOW GRANTS FOR 'Daniel'@'%';   -- ejemplo: la cuenta de 'Asegurar bases de Datos/Crear Usuario.sql'
*/

SELECT * FROM mysql.user;

/*
   Dos cosas prácticas de esta consulta:
   - Necesita privilegio SELECT sobre el esquema 'mysql'. Con un usuario de
     aplicación normal falla por permisos, y así debe ser.
   - El SELECT * arrastra authentication_string, o sea los hashes de todas las
     contraseñas del servidor. Se mira, no se copia a un chat ni a un ticket.
*/

/* ============================================================================
   ADMINISTRAR USUARIOS SIN ROMPER PRODUCCIÓN
   ----------------------------------------------------------------------------
   - Las cuentas se cambian con sentencias (CREATE / ALTER / DROP USER, GRANT /
     REVOKE), nunca con UPDATE o DELETE sobre mysql.user. En MySQL 8.0 esa
     escritura directa no está deshabilitada: el manual la desaconseja y la da
     por "hecha bajo tu propio riesgo" (el servidor puede ignorar filas mal
     formadas). Ese cambio directo recién tiene efecto después de FLUSH
     PRIVILEGES, o de reiniciar el servidor, tanto en 5.7 como en 8.0. Por eso
     el camino correcto son las sentencias de administración de cuentas (CREATE
     USER, ALTER USER, DROP USER, GRANT, REVOKE), no el DML directo.
   - El par User + Host se escribe siempre completo. Un '%' en Host significa
     "desde cualquier máquina", y es la puerta que más queda abierta.
   - Privilegio mínimo: lo que la aplicación necesita sobre la base que usa, no
     ALL PRIVILEGES global.
   - SHOW GRANTS es la fuente para auditar: sin USING, lista los privilegios
     otorgados directamente a la cuenta y los nombres de los roles que tiene,
     pero no los privilegios que esos roles traen. Para ver los de un rol hay
     que usar SHOW GRANTS FOR <cuenta> USING <rol>.

   ----------------------------------------------------------------------------
   NIVEL PRO: ROLES, LA FORMA MODERNA DE REPARTIR PERMISOS (MySQL 8.0+)
   ----------------------------------------------------------------------------
   Otorgar permiso por permiso a cada usuario no escala: con veinte cuentas
   iguales, cada cambio de permisos se repite veinte veces. Un rol es un paquete
   de privilegios con nombre que después se le asigna a las cuentas.
   -- Estructura ilustrativa (nombres de ejemplo):
   -- CREATE ROLE 'solo_lectura';
   -- GRANT SELECT ON <base>.* TO 'solo_lectura';
   -- GRANT 'solo_lectura' TO 'Daniel'@'%';
   Cambiar el paquete cambia a todas las cuentas que lo usan, y revocar el rol
   quita el acceso de una sola vez.
============================================================================ */
