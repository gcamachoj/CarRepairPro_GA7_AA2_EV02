from app import app, db, Cliente


app_context = app.app_context()
app_context.push()

def actualizar_cliente(IdCliente):
    cliente=Cliente.query.get(IdCliente)
    if cliente:
        nuevos_datos = {
            'IdTipoCliente':1,
             'CC_NIT':'123456', 
             'Nombres':'Guille', 
             'IdCiudad':1, 
             'Direccion':'Calle 1 cra 1', 
             'email':'guille@hotmail.com', 
             'telefono':'444444444'
        }
        

        for key, value in nuevos_datos.items():
            # Verificamos si el campo a actualizar existe en la clase Cliente
            if hasattr(Cliente, key):
                setattr(cliente, key, value)
            else:
                print(f"El campo '{key}' no existe en la clase Cliente.")
        db.session.commit()
        print("Cliente actualizado correctamente")
    else:
        print("Cliente no encontrado")

if __name__ == "__main__":
    id_cliente = 6  # Define aquí el ID del cliente que deseas actualizar
    actualizar_cliente(id_cliente)

app_context.pop()