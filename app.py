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
from modelos import Cliente, TipoCliente, Ciudad # Importamos el modelo ciudad del archivo modelos

# Instanciamos la aplicacion
app = Flask(__name__)  
app.config['SECRET_KEY'] = 'SENA'
# Configuramos la base de datos mysql 
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+mysqlconnector://root:root@localhost/taller'  
app.register_blueprint(vehiculos_bp)
app.register_blueprint(ordenes_bp)
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
    
# === ENDPOINTS CLIENTES =============================================================
#***********************************************************************************
@app.route('/clientes')
def clientes():
    clientes = Cliente.query.all() # Consulta todos los clientes en la base de datos
    return render_template('clientes/clientes.html', clientes=clientes)

@app.route('/crear_cliente')
def crear_cliente():
    ciudades = Ciudad.query.all()
    tiposCliente = TipoCliente.query.all()
    return render_template('clientes/crear_cliente.html', ciudades=ciudades, tiposCliente=tiposCliente)



@app.route('/clientes/guardar_cliente', methods=["POST"])
def guardar_cliente():
    cliente = Cliente(
                      IdTipoCliente=request.form['InputIdTipoCliente'], 
                      CC_NIT = request.form['InputCC_Nit'],
                      Nombres = request.form['InputNombres'], 
                      IdCiudad= request.form['InputIdCiudad'], 
                      Direccion=request.form['InputDireccion'],
                      email=request.form['InputEmail'],
                      telefono= request.form['InputTelefono']                
                      )
    db.session.add(cliente)
    db.session.commit()
    flash('¡Cliente guardado exitosamente!', 'success')
    return redirect(url_for('clientes'))


@app.route('/clientes/<int:cliente_id>')
def detalleClientes(cliente_id):
    cliente= Cliente.query.get_or_404(cliente_id)
    tiposCliente = TipoCliente.query.all()
    ciudades = Ciudad.query.all()
    return render_template('clientes/detalle_clientes.html', cliente=cliente, tiposCliente = tiposCliente, ciudades = ciudades) 
 

@app.route('/eliminar-cliente/<int:cliente_id>')
def eliminarCliente(cliente_id):
    Cliente.query.filter_by(IdCliente = int(cliente_id)).delete()
    db.session.commit()   
    flash('¡Cliente eliminado exitosamente!', 'success')
    return redirect(url_for('clientes')) 
#------------------------------------------------------

@app.route('/actualizar-cliente/<int:cliente_id>', methods=['GET','POST'])
def actualizar_cliente(cliente_id):
    cliente = Cliente.query.filter_by(IdCliente = int(cliente_id)).first()
    tiposCliente = TipoCliente.query.all()
    ciudades = Ciudad.query.all()
    
    if cliente:
        if request.method == 'POST':
            # Actualizar datos del cliente
            cliente.Nombres = request.form['InputNombres']
            cliente.IdTipoCliente=request.form['InputIdTipoCliente']
            cliente.CC_NIT = request.form['InputCC_Nit']
            cliente.IdCiudad= request.form['InputIdCiudad']
            cliente.Direccion=request.form['InputDireccion']
            cliente.email=request.form['InputEmail']
            cliente.telefono= request.form['InputTelefono'] 
            db.session.commit()
            flash('¡Cliente actualizado exitosamente!', 'success')
            return redirect(url_for('clientes'))
        else:
            return render_template('clientes/actualizar_cliente.html', cliente=cliente, tiposCliente = tiposCliente, ciudades = ciudades)
    else:
        return "Cliente no encontrado", 404


#Ejecucion
    
if __name__ == "__main__":
    app.run(debug=True)

#-----------------------------------------------------------------------------   
#--- Rutas:


