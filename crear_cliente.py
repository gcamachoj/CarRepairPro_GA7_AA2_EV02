from app import app, db, Cliente

# se define la funcion 
def crear_cliente(getIdTipoCliente, getCC_NIT, getNombres, getIdCiudad, getDireccion, geetEmail, getTelefono):
    
    try:
        app_context = app.app_context()
        app_context.push()

        nuevo_cliente = Cliente(IdTipoCliente=getIdTipoCliente, CC_NIT=getCC_NIT, Nombres=getNombres, IdCiudad = getIdCiudad, Direccion= getDireccion, email=geetEmail, telefono=getTelefono)
        db.session.add(nuevo_cliente)
        db.session.commit()

        app_context.pop()
        
        return "Cliente creado exitosamente"
    except Exception as e:
        return f"Error al crear cliente: {str(e)}"



# Llamada a la función
print(crear_cliente(1, '33433', 'Juan Jose David Camacho leal', 1, 'Calle 1 N1', 'guiller.cccc@gmail.com', '123456'))