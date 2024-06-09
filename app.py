# Importación de librerias:
    # * Flask:              Es el framework o marco de trabajo de base para el backend
    # * Redirect:           Modulo de Flask  que se usa para redirigir a otra pagina
    # * url_for:            Utiliería para tomar la url de otra ruta de la ap.
    # * render_template:    Utilería que se usa para renderizar los archivos del front.
    # } Request:            Utileria para recibir datos de un formulario
    # * SqlAlchemy: Librería de python como base ORM para modelar los datos de la base de y representarlos como como objetos dentro del backend. Bajo esta lbirería se crean las clases de cada componente de la lógica del negocio.


from flask import Flask, redirect, url_for, render_template, request, flash, session
from flask_sqlalchemy import SQLAlchemy
from extensions import db  # Importa db desde extensions.py
# Registra las rutas del componente vehiculos en el archivo app.py
from modulos.vehiculos.routes import vehiculos_bp 
from modulos.ordenes.routes import ordenes_bp 
from modulos.clientes.routes import clientes_bp
from modelos import Cliente, TipoCliente, Ciudad # Importamos el modelo ciudad del archivo modelos
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps  # Importa wraps para crear decoradores
from decorators import login_required


# Instanciamos la aplicacion
app = Flask(__name__)  
app.config['SECRET_KEY'] = 'SENA'
# Configuramos la base de datos mysql 
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:root@localhost/taller'  
app.register_blueprint(vehiculos_bp)
app.register_blueprint(ordenes_bp)
app.register_blueprint(clientes_bp)

# # Inicializa la extensión SQLAlchemy
db.init_app(app)


# ENDPOINTS =======================================================================
# =============================================================================
@app.route('/')
def redirect_to_login():
    return redirect(url_for('login')) 

@app.route('/login', methods=['GET','POST'])
def login():
    if request.method =='POST':
        username = request.form['usuario']
        password = request.form['password']
        user = Usuario.query.filter_by(Username = username).first()
        if user and check_password_hash(user.Password, password):
            session['user_id'] = user.IdUsuario
            return redirect(url_for('index'))
        else:
            flash('nombre de usuario o contraseña invalida', 'danger')

    return render_template('login.html')

@app.route('/index')
@login_required
def index():
    return render_template('index.html')
 

@app.route('/registro', methods=['GET', 'POST'])
def registro():    
    if request.method == 'POST':
        # Procesar datos y registrar al usuariO 
        # redirigir ala pagina de inicio de sesion a a otra pagina despues de registrar al usuario
        
        username = request.form['username']
        password = request.form['password']
        hashed_password = generate_password_hash(password, method='pbkdf2:sha256')  
        new_user = Usuario(Username = username, Password = hashed_password)
        db.session.add(new_user)
        db.session.commit()
    
        flash('¡Usuario registrado exitosamente!', 'success')
        return redirect(url_for('login'))
    # Si el método es get, simplemente se renderiza el formulario de registro
    return render_template('registro.html')
    


# Moduos que no están en el alcance del proyecto
@app.route('/empleados')
def alcance_limitado():
    return render_template('demo/demo.html')


## cerrar sesion-------------------------------------------------------
@app.route('/logout')
def logout():
    # Elimina la clave 'user_id' de la sesión
    session.pop('user_id', None)
    flash('¡Has cerrado sesión exitosamente!', 'success')
    return redirect(url_for('login'))



#-----------------------------------------------------------------------------   
# clases modelos
class Usuario(db.Model):
    __tablename__       = 'usuarios'
    IdUsuario           = db.Column(db.Integer, primary_key=True, autoincrement = True)
    Username            = db.Column(db.String(50), unique=True, nullable = False)
    Password            = db.Column(db.String(120), nullable = False)
    IdRol               = db.Column(db.Integer, nullable  =True)
    IdEmpleado          = db.Column(db.Integer, nullable = True)
    IdCliente           = db.Column(db.Integer, nullable = False)

#Ejecucion
    
if __name__ == "__main__":
    app.run(debug=True)