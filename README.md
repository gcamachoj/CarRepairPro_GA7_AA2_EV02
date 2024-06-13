## Este aplicativo contiene el desarrollo de la actividad: GA7-220501096-AA2-EV02 DE MODULOS  SOFTWARE CODIFICADOS Y PROBADOS.

Esta aplicacions consta de un backend elaborado Flask, el cual es un framework web ligero y versátil escrito en Python que se utiliza para crear aplicaciones web rápidas y escalables. Se complementa con la librería SQLAlchemy que proporciona una capa de abstracción sobre las bases de datos relacionales comportándose como un ORM (Mapeo Objeto-Relacional), para  interactuar con la base de datos utilizando objetos y consultas en lugar de escribir SQL directamente. La base de datos está elaborada en Mysql. En los complementos encontrará detalles sobre la base de datos y la estructura del desarrollo en general.


## INSTRUCCIONES 

1. Instale en su maquina con Windows un entorno virtual de python:
Cree una carpeta para instalar el proyecto. ingrese a la carpeta creada y ejecute el comando:

*python -m venv venv*

2. Activar el entorno virtual:
ejecutar: 
***venv\Scripts\activate***

Esto cambia el prompt de la linea de comando activando el ambiente virtual.

hasta aqui el proceso es similar al de la siguiente imagen:

![Esquema base de datos](static/complementos/crear_entorno_python.PNG)




3. clonar el repositorio. Ejecutar en linea de comandos:

***git clone https://github.com/gcamachoj/CarRepairPro_GA7_AA2_EV02.git***

4. Ingresar a la carpeta CarRepairPro_GA7_AA2_EV02
5. 
6. instalar las dependencias:

***pip install -r requirements.txt***

6. ejecutar la aplicacion. Ejecutar:

***flask run***

Este comando creará la ruta del servidor. Ingrese dicha ruta en el explorador de internet.

7. El archivo index, contiene informacion explicativa sobre el funcionamiento de esta versión del aplicativo.

## Instalación de la base de datos ##


![Esquema base de datos](static/complementos/ESQUEMA%20RELACIONAL%20DE%20BASE%20DE%20DATOS.png)
<figcaption>Modelo Relacional de base de datos</figcaption>

7.2. Cargue la carpeta creada en el IDE "visual studio code" o el ide de su preferencia. Posteriormente Abra una terminal de linea de comando nueva en la carpeta de CarRepairpro_GA7_AA2_EV02.

8. Para la instalacion de la base de datos desacargue el archivo del script con nombre similar a (20240324_script_creación_bd_taller_v3.sql), este archivo puede variar en nombre de acuerdo a la version incluido en la carpeta static/complementos:

9. Cargue el script en su aplicación de MySQL y ejecutelo. El scritp creará la base de datos "taller" con todas las tablas.  Actualice el listado de base de datos para verificar la nueva base de datos existente. Mantenga abierta la ventana de la aplicación de MySQL para validar los procedimientos CRUD.

10. Modifique la parametrización de conexión a la base de datos en el archivo app.py en la linea:

***app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:root@localhost/taller'***  

donde:

**root(1)** = usuario

**root(2)** = contraseña

**localhost** = url base de datos

**taller** = nombre de la base de datos

Una vez configurada la conexión a la base de datos puede proceder a ejecutar la aplicación con el comando **flask run** desde la terminal en la carpeta CarRepairpro_GA7_AA2_EV02.

Para adicionar los datos de talbas secundarias copie el contenido del archivo rellenar_datos_prueba.txt en su editor mysql y ejecutelo.  Esto llenará las tablas de parámetros y selectores con datos de pruebas. 

En caso de que quiera validar los cruds correspondientes a actividades anteriores: 

## Validación de funcionalidades CRUD: ##

Dado que se contiene una base de datos relacional pura en blanco, se debe ingresar primero datos de tablas secundarias.

Esta versión de la aplicación se limita a pruebas de CRUD desde la línea de comandos ejecutando y modificando para ello scripts del código backend desde la consola, lo cual corresponde al alcance de la actividad a presentar.

## Creacion de registros (CREATE): ##
1. Crear registro de ciudad:
desde linea de comandos ejecutar:
***python crear_ciudad.py***
Este archivo ejecuta la creación de la ciudad predeterminada en el script del archivo. Puede modificar el argumento en el final del archivo para incluir otra ciudad en la linea que contiene:

***print(crear_ciudad('Bogota'))***
Ingrese a las tablas de la base de datos para verificar los resultados.

2. Crear tipo de Carrocería: la ejecución de este script genera un registro en la tabla ***TipoCarroceria***. Ejecute el comando: 
***python crear_tipo_carroceria.py***

Al igual que en el script anterior y los siguientes puede cambiar los argumentos del script para ingresar un registro con valores diferentes"

3. Ingresar registro en tabla Marcas:  para ingresar el primer registro en la tabla marcas ejecute:
***python crear_marca.py***

4. Ingresar Tipo de Cliente: ingrese el siguiente comando para ingresar un tipo de cliente:
***python crear_tipo_cliente.py***

Ahora que se realizaron pruebas de creación de registros, se realizarán pruebas de lectura y modificación.

Para ello primero creemos un registro en la tabla cliente. Ejecutar:

***python crear_cliente.py***

Para listar desde la aplicación los clientes ingresados, ingresamos a la pagina ***localhost:5000/clientes***.

Puede cambiar los parámetros del script para ingresar otros registros de cliente.

## Actualizacion y Eliminación de registros ##
5. Actualizar registros:
Ejecute el comando:
***python actualizar_cliente.py*** 
Se actualizará el cliente 1 con los datos del script. Puede realizar cambios, teniendo en cuenta que el IdCliente corresponde al código de PrimaryKey del cliente que va a actualizar.

6. Eliminar registro de cliente:
Ejecute:
***python eliminar_cliente.py 1***
Se eliminará el cliente con primaryKey 1 de la base de datos. Liste nuevamente los clientes para comprobarlo.


Hasta aquí todo lo contenido de la actividad en referencia.
