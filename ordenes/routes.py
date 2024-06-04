from flask import Blueprint, render_template, request, redirect, flash, url_for
from modelos import Vehiculo, Marca, Tipos_Carroceria, Ciudad, Orden  # Importacion de modelos de datos del orm
from extensions import db  # importar servicio db para instanciar sqlalchemy y manipular los modelos de datos

# Define un blueprint para las rutas de los templates de vehículos
ordenes_bp = Blueprint('ordenes_bp', __name__, template_folder='../templates/ordenes')


#========================================================================================================
# ***** ENDPOINTS ORDENES (RUTAS) ********************************************************************** 
#=========================================================================================================

# ----1. Listar ordenes ---------------------------------------------------------------------------------

@ordenes_bp.route('/ordenes') 
def ordenes():
    template_folder_path = ordenes_bp.template_folder
    ordenes = Orden.query.all() 
    # Línea de prueba para verificar la ruta del template folder (descomentala si es necesario)
    #return render_template('vehiculos/vehiculos.html')  #modo ok
    for orden in ordenes:
        print(f"ID: {orden.IdOrden}")
    # Renderizar el template con la lista vehiculos
    return render_template('ordenes.html', ordenes = ordenes) 


# ---- 2.1 Abrir formulario de crear vehiculo .............................................................
