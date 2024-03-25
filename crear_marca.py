from app import app, db, Marca

def crear_marca(getMarca):
    try:
        app_context = app.app_context()
        app_context.push()

        nuevaMarca = Marca(Marca = getMarca)
        db.session.add(nuevaMarca)
        db.session.commit()

        app_context.pop()

        return "Marca creada exitosamente"
    except Exception as e:
        return f"Errora al crear marca: {str(e)}"
    

## llamada a la funcion:
print(crear_marca('Mazda'))