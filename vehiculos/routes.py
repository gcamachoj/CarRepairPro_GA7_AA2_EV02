from flask import Blueprint, render_template
#from modelos import Vehiculo

# Define un blueprint para hacer enlace a las rutas de los templates de vehiculos
vehiculos_bp = Blueprint('vehiculos_bp', __name__, template_folder='../templates/vehiculos')

@vehiculos_bp.route('/vehiculos')
def vehiculos():
    template_folder_path = vehiculos_bp.template_folder
    #return f"hola soy la primera linea de app en vehiculos: {template_folder_path}"   # linea de prueba
    #vehiculos = Vehiculo.query.all()
    #return render_template('vehiculos/vehiculos.html')  #modo ok
    return render_template('vehiculos.html')  #modo no funciona
    