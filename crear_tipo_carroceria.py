from app import app, db, Tipo_Carroceria

def crear_tipo_carroceria(getTipoCarroceria):
    try:
        app_context = app.app_context()
        app_context.push()

        nuevoTipoCarroceria = Tipo_Carroceria(TipoCarroceria = getTipoCarroceria)
        db.session.add(nuevoTipoCarroceria)
        db.session.commit()

        app_context.pop()

        return "tipo de carroceria creado exitosamente!"

    except Exception(e) as e:
        return f"Error al crear tipo de carroceria: {str(e)}"
    

print(crear_tipo_carroceria("Furgon"))