from flask import Blueprint, render_template, request, redirect, flash, url_for
from modelos import Vehiculo, Marca, Tipos_Carroceria, Ciudad, Orden, Cliente, Empleado, Estado_os  # Importacion de modelos de datos del orm
from extensions import db  # importar servicio db para instanciar sqlalchemy y manipular los modelos de datos

# Define un blueprint para las rutas de los templates de vehículos
ordenes_bp = Blueprint('ordenes_bp', __name__, template_folder='../../templates/ordenes')


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


# ---- 2.1 Abrir formulario de crear Orden .............................................................

@ordenes_bp.route('/ordenes/crear') 
def crear_orden():
     clientes = Cliente.query.all()
     vehiculos = Vehiculo.query.all()
     empleados = Empleado.query.all()
     estados_os = Estado_os.query.all()
     return render_template('crear_orden.html', clientes = clientes, vehiculos = vehiculos, empleados = empleados, estados_os = estados_os)



# ---- 2.2 Guardar datos de la orden # --------------------------------------------------------------------

@ordenes_bp.route('/ordenes/guardar_orden', methods=["POST"])  #
def guardar_orden():
    try:
        # Convertir KM_Salida a None si está vacío
        km_salida = request.form.get('InputKM_Salida')
        fecha_fin_servicio = request.form.get('InputFechaFinServicio')
        if km_salida == '':
            km_salida = None
        else:
            km_salida = int(km_salida)  # Convertir a entero si no está vacío

        if fecha_fin_servicio =='':
            fecha_fin_servicio = None

        orden = Orden(
            IdCliente=request.form['InputIdCliente'],
            IdVehiculo=request.form['InputIdVehiculo'], 
            IdMecanico=request.form['InputIdMecanico'], 
            IdEstadoOS=request.form['InputIdEstadoOS'],
            KM_Entrada=request.form['InputKM_Entrada'],  
            KM_Salida=km_salida,  # Asignar el valor modificado de KM_Salida
            FechaIngreso=request.form['InputFechaIngreso'],
            FechaFinServicio=fecha_fin_servicio,
            Observaciones=request.form['InputObservaciones'] 
        )
        db.session.add(orden)
        db.session.commit()
        flash('Orden guardada exitosamente!', 'success')
        return redirect(url_for('ordenes_bp.ordenes'))
    except Exception as e:
        db.session.rollback()
        flash('Error al guardar la orden', 'error')
        print(e)  # Puedes imprimir el error para depurar si algo sale mal
        return redirect(url_for('ordenes_bp.ordenes'))