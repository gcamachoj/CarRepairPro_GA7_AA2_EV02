from flask import Blueprint, render_template, request, redirect, flash, url_for
from modelos import Vehiculo, Marca, Tipos_Carroceria, Ciudad
from extensions import db

#from modelos import Vehiculo

# Define un blueprint para las rutas de los templates de vehículos
vehiculos_bp = Blueprint('vehiculos_bp', __name__, template_folder='../templates/vehiculos')


@vehiculos_bp.route('/vehiculos') # Listar vehículos
def vehiculos():
    template_folder_path = vehiculos_bp.template_folder
    vehiculos = Vehiculo.query.all() 
    # Línea de prueba para verificar la ruta del template folder (descomentala si es necesario)
    #return render_template('vehiculos/vehiculos.html')  #modo ok
    for vehiculo in vehiculos:
        print(f"ID: {vehiculo.Placa}")
    # Renderizar el template con la lista vehiculos
    return render_template('vehiculos.html', vehiculos = vehiculos) 

@vehiculos_bp.route('/vehiculos/crear') # Abrir formulario de crear vehiculo
def crear_vehiculo():
    ciudades = Ciudad.query.all()
    marcas = Marca.query.all()
    carrocerias = Tipos_Carroceria.query.all()
    return render_template('crear_vehiculo.html', ciudades=ciudades, marcas=marcas, carrocerias = carrocerias)

@vehiculos_bp.route('/vehiculos/guardar_vehiculo', methods=["POST"])
def guardar_vehiculo():
    vehiculo = Vehiculo(
                      Placa = request.form['InputPlaca'],
                      IdMarca = request.form['InputIdMarca'], 
                      Linea= request.form['InputLinea'], 
                      Modelo=request.form['InputModelo'],
                      Color=request.form['InputColor'],
                      IdTipoCarroceria= request.form['InputIdTipoCarroceria'],  
                      IdCiudad= request.form['InputIdCiudad']            
                      )
    db.session.add(vehiculo)
    db.session.commit()
    flash('Vehiculo guardado exitosamente!', 'success')
    return redirect(url_for('vehiculos_bp.vehiculos'))


@vehiculos_bp.route('/vehiculos/<int:vehiculo_id>')
def detalleVehiculos(vehiculo_id):
    vehiculo= Vehiculo.query.get_or_404(vehiculo_id)

    return render_template('vehiculos/detalle_vehiculos.html', vehiculo=vehiculo) 



@vehiculos_bp.route('/actualizar-vehiculo/<int:vehiculo_id>', methods=['GET','POST'])
def actualizar_vehiculo(vehiculo_id):
    vehiculo = Vehiculo.query.filter_by(IdVehiculo = int(vehiculo_id)).first()
    marcas = Marca.query.all()
    ciudades = Ciudad.query.all()
    tipos_carroceria = Tipos_Carroceria.query.all()

    if vehiculo:
        if request.method == 'POST':
            # Imprimir los datos recibidos
            print("Datos recibidos:", request.form)

            # Actualizar datos del vehiculo
            vehiculo.Placa = request.form['InputPlaca']
            vehiculo.IdMarca=request.form['InputIdMarca']
            vehiculo.Linea= request.form['InputLinea']
            vehiculo.Modelo=request.form['InputModelo']
            vehiculo.Color=request.form['InputColor']
            vehiculo.IdTipoCarroceria=request.form['InputIdTipoCarroceria']
            vehiculo.IdCiudad= request.form['InputIdCiudad'] 
            
            db.session.commit()
            flash('¡Vehículo actualizado exitosamente!', 'success')
            return redirect(url_for('vehiculos_bp.vehiculos'))
        else:
            return render_template('vehiculos/actualizar_vehiculo.html', vehiculo=vehiculo, marcas=marcas, ciudades = ciudades, tipos_carroceria = tipos_carroceria)
    else:
        return "vehículo no encontrado", 404
    


@vehiculos_bp.route('/eliminar-vehiculo/<int:vehiculo_id>')
def eliminarVehiculo(vehiculo_id):
    Vehiculo.query.filter_by(IdVehiculo = int(vehiculo_id)).delete()
    db.session.commit()   
    flash('Vehiculo eliminado exitosamente!', 'success')
    return redirect(url_for('vehiculos_bp.vehiculos')) 