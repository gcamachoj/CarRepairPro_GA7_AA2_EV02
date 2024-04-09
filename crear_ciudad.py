from app import app, db, Ciudad


def crear_ciudad(getCiudad):
    try:
        app_context = app.app_context()
        app_context.push()

        nuevaCiudad = Ciudad(Ciudad = getCiudad)
        db.session.add(nuevaCiudad)
        db.session.commit()
        app_context.pop()
        return "Ciudad creara con exito!"
    
    except Exception as e:
        return f"Error al crear ciudad: {str(e)}"

print(crear_ciudad('Manizalez'))
