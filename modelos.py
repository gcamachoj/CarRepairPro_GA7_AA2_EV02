from extensions import db
# Crear el modelo vehiculo

class Vehiculo(db.Model):
    __tablename__ = 'vehiculos'
    IdVehiculo =        db.Column(db.Integer, primary_key = True)
    Placa =             db.Column(db.String(10), nullable = False)
    IdMarca =           db.Column(db.Integer, db.ForeignKey('marcas.IdMarca'), nullable=False) 
    # marcas es la referencia creada en la relacion (ver modelo Marcas)
    Linea =             db.Column(db.String(45), nullable = False)
    Modelo =            db.Column(db.Integer, nullable = False)
    Color =             db.Column(db.String(45), nullable = False)
    IdTipoCarroceria =  db.Column(db.Integer, db.ForeignKey('tipos_carroceria.IdTipoCarroceria'), nullable = False)  
    # tipos_carroceria es la referencia creada en la relación. ver modelo Tipos_carroceria
    IdCiudad =          db.Column(db.Integer, nullable = False)

    #Crear el modelo Marca
class Marca(db.Model):
    __tablename__= 'marcas'
    IdMarca = db.Column(db.Integer, primary_key = True)
    Marca = db.Column(db.String(45), nullable = False)
    vehiculos = db.relationship('Vehiculo', backref='marca', lazy=True) 
    # Establece relacion entre las tablas vehiculos y marcas, así para acceder a la marca de un vehículo se usará vehiculo.marca.Marca desde la pplantilla requerida.


# Crear el modelo Tipo Carroceria
class Tipos_Carroceria(db.Model):
    __tablename__ ='tipos_carroceria'
    IdTipoCarroceria = db.Column(db.Integer, primary_key = True)
    TipoCarroceria = db.Column(db.String(45), nullable = False)
    # Establece relacion entre las tablas vehiculos y tipos_carrocería, así para acceder a los tipos vehiculos de determinado tipo de carrocería.
    vehiculos = db.relationship('Vehiculo', backref='tipo_carroceria', lazy=True)  
    # Vehiculo es la clase del modelo, tipo_carrocería es el nombre de la referencia a emplear.

# Se crea el modelo ciudad:
class Ciudad(db.Model):
    __tablename__ = 'ciudades'
    IdCiudad = db.Column(db.Integer, primary_key=True)
    Ciudad = db.Column(db.String(45), nullable = False)