# Importación de librerias:
    # * Flask:              Es el framework o marco de trabajo de base para el backend
    # * Redirect:           Modulo de Flask  que se usa para redirigir a otra pagina
    # * url_for:            Utiliería para tomar la url de otra ruta de la ap.
    # * render_template:    Utilería que se usa para renderizar los archivos del front.
    
    # * SqlAlchemy: Librería de python como base ORM para modelar los datos de la base de y representarlos como como objetos dentro del backend. Bajo esta lbirería se crean las clases de cada componente de la lógica del negocio.


from flask import Flask, redirect, url_for, render_template
from flask_sqlalchemy import SQLAlchemy



# Instanciamos la aplicacion
app = Flask(__name__)  

# Configuramos la base de datos mysql 
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:root@localhost/taller'  

# creamos el objeto db utilizando la instancia de la aplicacion 
db = SQLAlchemy(app)


### MODELOS DE DATOS ##########################################################################

# Se crea el modelo ciudad:
class Ciudad(db.Model):
    __tablename__ = 'ciudades'
    IdCiudad = db.Column(db.Integer, primary_key=True)
    Ciudad = db.Column(db.String(45), nullable = False)

# Se crea el modelo de datos para la tabla TipoCliente
class TipoCliente(db.Model):
    __tablename__='Tipo_Cliente'
    idTipoCliente = db.Column(db.Integer, primary_key=True)
    TipoCliente = db.Column(db.String(45), nullable = False)
    IdEstado = db.Column(db.Integer, nullable=False)


# Creamos el modelo de datos para la tabla Cliente usando el ORM SQLAlchemy
class Cliente(db.Model):
    __tablename__ = 'clientes'    
    IdCliente = db.Column(db.Integer, primary_key=True)
    IdTipoCliente = db.Column(db.Integer, nullable = False)
    CC_NIT = db.Column(db.String(50), nullable = False)
    Nombres = db.Column(db.String(100), nullable = False)
    IdCiudad = db.Column(db.Integer, nullable = False)
    Direccion = db.Column(db.String(150), nullable = False)
    email = db.Column(db.String(100), nullable = False)
    telefono = db.Column(db.String(50), nullable = False)
    
# Crear el modelo vehiculo
class Vehiculo(db.Model):
    __tablename__ = 'Vehiculos'
    IdVehiculo = db.Column(db.Integer, primary_key = True)
    Placa = db.Column(db.String(10), nullable = False)
    IdMarca = db.Column(db.Integer, nullable = False)
    Linea = db.Column(db.String(45), nullable = False)
    Modelo = db.Column(db.Integer, nullable = False)
    Color = db.Column(db.String(45), nullable = False)
    IdTipoCarroceria = db.Column(db.Integer, nullable = False)

# Crear el modelo Tipo Carroceria
class Tipo_Carroceria(db.Model):
    __tablename__ ='tipos_carroceria'
    IdTipoCarroceria = db.Column(db.Integer, primary_key = True)
    TipoCarroceria = db.Column(db.String(45), nullable = False)

#Crear el modelo Marca
class Marca(db.Model):
    __tablename__= 'Marcas'
    IdMarca = db.Column(db.Integer, primary_key = True)
    Marca = db.Column(db.String, nullable = False)


#Rutas
@app.route('/')
def redirect_to_login():
    return redirect(url_for('login')) 

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/index')
def index():
    return render_template('index.html')
    
@app.route('/base')
def base():
    return render_template('base.html')


@app.route('/clientes')
def clientes():
    clientes = Cliente.query.all() # Consulta todos los clientes en la base de datos
    return render_template('clientes.html', clientes=clientes)

@app.route('/crear_cliente')
def crear_cliente():
    return render_template('crear_cliente.html')

#---------------------------------------------------------------------------
#Ejecucion
    
if __name__ == "__main__":
    app.run(debug=True)

#-----------------------------------------------------------------------------   
#--- Rutas:


