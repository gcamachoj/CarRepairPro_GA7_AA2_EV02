from flask import Blueprint, render_template
from modelos import Vehiculo, Marca, Tipos_Carroceria 

#from modelos import Vehiculo

# Define un blueprint para las rutas de los templates de vehículos
vehiculos_bp = Blueprint('vehiculos_bp', __name__, template_folder='../templates/vehiculos')


@vehiculos_bp.route('/vehiculos')
def vehiculos():
    template_folder_path = vehiculos_bp.template_folder
    vehiculos = Vehiculo.query.all() 
    # Línea de prueba para verificar la ruta del template folder (descomentala si es necesario)
    #return render_template('vehiculos/vehiculos.html')  #modo ok
    for vehiculo in vehiculos:
        print(f"ID: {vehiculo.Placa}")
    
    
    # Renderizar el template con la lista vehiculos
    return render_template('vehiculos.html', vehiculos = vehiculos) 
    