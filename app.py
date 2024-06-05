# Importación de librerias:
    # * Flask:              Es el framework o marco de trabajo de base para el backend
    # * Redirect:           Modulo de Flask  que se usa para redirigir a otra pagina
    # * url_for:            Utiliería para tomar la url de otra ruta de la ap.
    # * render_template:    Utilería que se usa para renderizar los archivos del front.
    # } Request:            Utileria para recibir datos de un formulario
    # * SqlAlchemy: Librería de python como base ORM para modelar los datos de la base de y representarlos como como objetos dentro del backend. Bajo esta lbirería se crean las clases de cada componente de la lógica del negocio.


from flask import Flask, redirect, url_for, render_template, request, flash
from flask_sqlalchemy import SQLAlchemy
from extensions import db  # Importa db desde extensions.py
# Registra las rutas del componente vehiculos en el archivo app.py
from modulos.vehiculos.routes import vehiculos_bp 
from modulos.ordenes.routes import ordenes_bp 
from modulos.clientes.routes import clientes_bp
from modelos import Cliente, TipoCliente, Ciudad # Importamos el modelo ciudad del archivo modelos

# Instanciamos la aplicacion
app = Flask(__name__)  
app.config['SECRET_KEY'] = 'SENA'
# Configuramos la base de datos mysql 
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:root@localhost/taller'  
app.register_blueprint(vehiculos_bp)
app.register_blueprint(ordenes_bp)
app.register_blueprint(clientes_bp)
# c# Inicializa la extensión SQLAlchemy
db.init_app(app)


# ENDPOINTS =======================================================================
# =============================================================================
@app.route('/')
def redirect_to_login():
    return redirect(url_for('login')) 

@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/index')
def index():
    return render_template('index.html')
 
#Ejecucion
    
if __name__ == "__main__":
    app.run(debug=True)

#-----------------------------------------------------------------------------   
#--- Rutas:


