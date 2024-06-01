from extensions import db
# Crear el modelo vehiculo

class Vehiculo(db.Model):
    __tablename__ = 'Vehiculos'
    IdVehiculo = db.Column(db.Integer, primary_key = True)
    Placa = db.Column(db.String(10), nullable = False)
    IdMarca = db.Column(db.Integer, nullable = False)
    Linea = db.Column(db.String(45), nullable = False)
    Modelo = db.Column(db.Integer, nullable = False)
    Color = db.Column(db.String(45), nullable = False)
    IdTipoCarroceria = db.Column(db.Integer, nullable = False)