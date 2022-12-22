# control_bd_digikam
Este script esta pensado para solucionar un problema con el programa de fotografia Digikam.

 El problema es el siguiente. Digikam funciona perfectamente pero con una base de datos en la cual estan todos los datos de tus fotos
 como son las etiquetas, las estrellas, etc. Pues bien, esa base de datos lo normar es tenerla en tu maquina local para que sea mas fluido
 el funcionamiento del mismo.

 ¿ Pero que pasa cuando queremos organizar las fotos en maquinas distintas ?.

 Pues que no tenemos la base de datos en esas otras maquinas, para eso esta este script.
 Lo que hace es pedirte en donde quieres tener la base de datos principal, que la he denominado (servidor), en la cual estara la base de datos,
 tambien te pedira la direccion de la base de datos en local.

 Cuando termines de trabajar con digikam, sincronizas con el servidor y se pasara la base de datos al servidor, y si trabajas con otra maquina
 solo tendras que sincronizar del servidor a local de esa maquina y tendras los mismos datos.


 # Opciones del menu del script.
Opcion  (0) Actualizar el script. Su nombre lo dice, si saco alguna actualizacion o mejora, con esta opcion se actualiza.

Opcion  (1) Ejecuta digikam. Pues eso ejecuta Digikam

Opcion  (2) Copiar la base de datos del servido a local. Sincroniza la base de datos de tu servidor y la coloca en local de tu maquina.

Opcion  (3) Copiar la base de datos local al servidor. Sincroniza al reves, para que la base de datos este en el servidor actualizada
                                                       y puedes acceder mas tarde desde otra maquina y tener los mismo datos

Opcion  (4) Ver el fichero de configuracion. Para que este script funcione tienes que indicarle la ruta del servidor como la ruta en local,
                                             con esta opcion puedes ver los datos.

Opcion  (5) Resetear la configuracion del script. Lo dicho, borra los datos de configuracion y te los pide de nuevo, sin ellos no puede funcionar.

Opcion  (6) Borra la configuracion de Digikam y la base de datos. Eso, deja a Digikam como recien instalado.

Opcion  (7) Crear un acceso directo en el escritorio. Te crea un acceso en el escritorio de forma automatica.

Opcion (90) Ayuda. Lo que estas viendo.

Opcion (99) Salir. Pues sale del script.
