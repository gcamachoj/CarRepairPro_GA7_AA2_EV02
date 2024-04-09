from app import app, db, Cliente

app_context = app.app_context()
app_context.push()


def eliminar_cliente(IdCliente):
    cliente = Cliente.query.get(IdCliente)
    if cliente:
        db.session.delete(cliente)
        db.session.commit()
        print("Cliente eliminado correctamente")
    else:
        print("Cliente no encontrado")


if __name__ == "__main__":
    import sys
    
    # Verificar si se proporcionó el ID del cliente como argumento
    if len(sys.argv) != 2:
        print("Uso: python eliminar_cliente.py <IdCliente>")
        sys.exit(1)
    
    # Obtener el ID del cliente de los argumentos de la línea de comandos
    IdCliente = int(sys.argv[1])
    
    # Llamar a la función eliminar_cliente con el ID del cliente proporcionado
    eliminar_cliente(26)

app_context.pop()