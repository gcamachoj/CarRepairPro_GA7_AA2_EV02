from app import app, db, TipoCliente


def crear_tipo_cliente(getTipoCliente, getIdEstado):
    try:
        app_context = app.app_context()
        app_context.push()

        nuevo_tipo_cliente = TipoCliente(TipoCliente=getTipoCliente, IdEstado=getIdEstado)
        db.session.add(nuevo_tipo_cliente)
        db.session.commit()

        app_context.pop()

        return "Tipo de cliente creado exitosamente"

    except Exception as e:
        return f"Error al crear cliente: {str(e)}"

# Llamada a la función
print(crear_tipo_cliente("Persona Natural", 1))