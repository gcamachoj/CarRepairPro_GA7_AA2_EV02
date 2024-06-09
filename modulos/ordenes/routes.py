from flask import Blueprint, render_template, request, redirect, flash, url_for
from modelos import Vehiculo, Marca, Tipos_Carroceria, Ciudad, Orden, Cliente, Empleado, Estado_os  # Importacion de modelos de datos del orm
from extensions import db  # importar servicio db para instanciar sqlalchemy y manipular los modelos de datos
from decorators import login_required # importa funcionalidad para validar inicio de sesion
# Define un blueprint para las rutas de los templates de vehículos
ordenes_bp = Blueprint('ordenes_bp', __name__, template_folder='../../templates/ordenes')


#========================================================================================================
# ***** ENDPOINTS ORDENES (RUTAS) ********************************************************************** 
#=========================================================================================================

# ----1. Listar ordenes ---------------------------------------------------------------------------------

@ordenes_bp.route('/ordenes') 
@login_required
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
@login_required
def crear_orden():
     clientes = Cliente.query.all()
     vehiculos = Vehiculo.query.all()
     empleados = Empleado.query.all()
     estados_os = Estado_os.query.all()
     return render_template('crear_orden.html', clientes = clientes, vehiculos = vehiculos, empleados = empleados, estados_os = estados_os)



# ---- 2.2 Guardar datos de la orden # --------------------------------------------------------------------

@ordenes_bp.route('/ordenes/guardar_orden', methods=["POST"])  #
@login_required
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
    
# 3.---- Filtrar Orden  (Detalles)-------------------------------------------------------------------------------

@ordenes_bp.route('/ordenes/<int:orden_id>')
@login_required
def detalleOrden(orden_id):
    orden= Orden.query.get_or_404(orden_id)

    return render_template('ordenes/detalle_orden.html', orden=orden) 
# 4 ---- actualizar Orden ---------------------------------------------------------------------------------
@ordenes_bp.route('/actualizar-orden/<int:orden_id>', methods=['GET','POST'])
@login_required
def actualizar_orden(orden_id):
    orden = Orden.query.filter_by(IdOrden = int(orden_id)).first()
    clientes = Cliente.query.all()
    vehiculos = Vehiculo.query.all()
    empleados = Empleado.query.all()
    estados_os = Estado_os.query.all()


    if orden:
        if request.method == 'POST':
            # Imprimir los datos recibidos
            print("Datos recibidos:", request.form)

            # Actualizar datos 

            orden.IdCliente = request.form['InputIdCliente']
            orden.IdVehiculo = request.form['InputIdVehiculo']
            orden.IdMecanico = request.form['InputIdMecanico']
            orden.IdEstadoOS = request.form['InputIdEstadoOS']
            orden.KM_Entrada = request.form['InputKM_Entrada']
            
            # Manejar el valor de KM_Salida, podría estar vacío
            km_salida = request.form['InputKM_Salida']
            if km_salida =='None':
                km_salida = None
            else:
                km_salida = int(km_salida) if km_salida.strip() else None
            orden.KM_Salida = km_salida
            # Manejar el valor de FechaFinServicio, podría estar vacío
            fecha_fin_servicio = request.form['InputFechaFinServicio']
            orden.FechaFinServicio = fecha_fin_servicio.strip() if fecha_fin_servicio.strip() else None
            
            orden.FechaIngreso = request.form['InputFechaIngreso']
            orden.Observaciones = request.form['InputObservaciones']
          
            
            db.session.commit()
            flash('Orden actualizada exitosamente!', 'success')
            return redirect(url_for('ordenes_bp.ordenes'))
        else:
            return render_template('ordenes/actualizar_orden.html', 
            orden=orden, clientes=clientes, vehiculos=vehiculos, empleados=empleados, estados_os=estados_os)
    else:
        return "Orden no encontrado", 404
    
    # ---- 5. Eliminar Orden -------------------------------------------------------------------------------------------

@ordenes_bp.route('/eliminar-orden/<int:orden_id>')
@login_required
def eliminar_Orden(orden_id):
    Orden.query.filter_by(IdOrden = int(orden_id)).delete()
    db.session.commit()   
    flash('Orden de Servicio eliminada exitosamente!', 'success')
    return redirect(url_for('ordenes_bp.ordenes')) 
    