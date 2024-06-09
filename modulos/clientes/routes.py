# -- Importación de librerías
from flask import Blueprint, render_template, request, flash, redirect, url_for
from extensions import db  # importar servicio db para instanciar sqlalchemy y manipular los modelos de datos
from modelos import Cliente, Ciudad, TipoCliente
from decorators import login_required

clientes_bp = Blueprint('clientes_bp', __name__, template_folder = '../../templates/clientes')


# === ENDPOINTS CLIENTES =============================================================
#***********************************************************************************

#---LISTAR CLIENTES ---------------------------------------------------------------

@clientes_bp.route('/clientes')
@login_required
def clientes():
    clientes = Cliente.query.all() # Consulta todos los clientes en la base de datos
    return render_template('clientes/clientes.html', clientes=clientes)


# -- FORMULARIO CREAR CLIENTE ------------------------------------------------------

@clientes_bp.route('/crear_cliente')
@login_required
def crear_cliente():
    ciudades = Ciudad.query.all()
    tiposCliente = TipoCliente.query.all()
    return render_template('clientes/crear_cliente.html', ciudades=ciudades, tiposCliente=tiposCliente)


# -- FORMULARIO GUARDAR CLIENTE  ------------------------------------------------------

@clientes_bp.route('/clientes/guardar_cliente', methods=["POST"])
@login_required
def guardar_cliente():
    cliente = Cliente(
                      IdTipoCliente=request.form['InputIdTipoCliente'], 
                      CC_NIT = request.form['InputCC_Nit'],
                      Nombre = request.form['InputNombre'], 
                      IdCiudad= request.form['InputIdCiudad'], 
                      Direccion=request.form['InputDireccion'],
                      email=request.form['InputEmail'],
                      telefono= request.form['InputTelefono']                
                      )
    db.session.add(cliente)
    db.session.commit()
    flash('¡Cliente guardado exitosamente!', 'success')
    return redirect(url_for('clientes_bp.clientes'))

# ---DETALLE DE CLIENTE  ----------------------------------------------------------
@clientes_bp.route('/clientes/<int:cliente_id>')
@login_required
def detalleClientes(cliente_id):
    cliente= Cliente.query.get_or_404(cliente_id)
    tiposCliente = TipoCliente.query.all()
    ciudades = Ciudad.query.all()
    return render_template('clientes/detalle_clientes.html', cliente=cliente, tiposCliente = tiposCliente, ciudades = ciudades)

#--- MODIFICAR DATOS CLIENTE ------------------------------------------------------

@clientes_bp.route('/actualizar-cliente/<int:cliente_id>', methods=['GET','POST'])
@login_required
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
            return redirect(url_for('clientes_bp.clientes'))
        else:
            return render_template('clientes/actualizar_cliente.html', cliente=cliente, tiposCliente = tiposCliente, ciudades = ciudades)
    else:
        return "Cliente no encontrado", 404


# ---ELIMINAR CLIENTE  ----------------------------------------------------------

@clientes_bp.route('/eliminar-cliente/<int:cliente_id>')
@login_required
def eliminarCliente(cliente_id):
    Cliente.query.filter_by(IdCliente = int(cliente_id)).delete()
    db.session.commit()   
    flash('¡Cliente eliminado exitosamente!', 'success')
    return redirect(url_for('clientes_bp.clientes')) 