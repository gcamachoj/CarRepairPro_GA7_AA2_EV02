from flask import Blueprint, render_template
from modelos import Vehiculo #adicionada
#from modelos import Vehiculo

# Define un blueprint para hacer enlace a las rutas de los templates de vehiculos
vehiculos_bp = Blueprint('vehiculos_bp', __name__, template_folder='../templates/vehiculos')


@vehiculos_bp.route('/vehiculos')
def vehiculos():
    template_folder_path = vehiculos_bp.template_folder
    vehiculos = Vehiculo.query.all() 
    clientes = "ss"
    #return f"hola soy la primera linea de app en vehiculos: {template_folder_path}"   # linea de prueba
    #vehiculos = Vehiculo.query.all()
    #return render_template('vehiculos/vehiculos.html')  #modo ok
    for vehiculo in vehiculos:
        print(f"ID: {vehiculo.Placa}")
    return render_template('vehiculos.html', vehiculos = vehiculos, clientes = clientes)  #pasamos el parametro vehiculo que será igual al objeto vehiculos definido en la función.
    
    # Consulta todos los clientes en la base de datos