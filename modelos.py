from extensions import db
# Crear el modelo vehiculo


# Se crea el modelo de datos para la tabla TipoCliente
class TipoCliente(db.Model):
    __tablename__='Tipo_Cliente'
    IdTipoCliente = db.Column(db.Integer, primary_key=True)
    TipoCliente = db.Column(db.String(45), nullable = False)
    IdEstado = db.Column(db.Integer, nullable=False)


# Creamos el modelo de datos para la tabla Cliente usando el ORM SQLAlchemy
class Cliente(db.Model):
    __tablename__ = 'clientes'    
    IdCliente = db.Column(db.Integer, primary_key=True)
    IdTipoCliente = db.Column(db.Integer, db.ForeignKey('Tipo_Cliente.IdTipoCliente'), nullable=False)
    CC_NIT = db.Column(db.String(50), nullable = False)
    Nombres = db.Column(db.String(100), nullable = False)
    IdCiudad = db.Column(db.Integer, nullable = False)
    Direccion = db.Column(db.String(150), nullable = False)
    email = db.Column(db.String(100), nullable = False)
    telefono = db.Column(db.String(50), nullable = False)

    tipo_cliente = db.relationship('TipoCliente', backref='clientes')
class Vehiculo(db.Model):
    __tablename__ =     'vehiculos'
    IdVehiculo =        db.Column(db.Integer, primary_key = True)
    Placa =             db.Column(db.String(10), nullable = False)
    IdMarca =           db.Column(db.Integer, db.ForeignKey('marcas.IdMarca'), nullable=False) 
    # marcas es la referencia creada en la relacion (ver modelo Marcas)
    Linea =             db.Column(db.String(45), nullable = False)
    Modelo =            db.Column(db.Integer, nullable = False)
    Color =             db.Column(db.String(45), nullable = False)
    IdTipoCarroceria =  db.Column(db.Integer, db.ForeignKey('tipos_carroceria.IdTipoCarroceria'), nullable = False)  
    # tipos_carroceria es la referencia creada en la relación. ver modelo Tipos_carroceria
    IdCiudad =          db.Column(db.Integer, db.ForeignKey('ciudades.IdCiudad'), nullable = False)
    # Crea el campo foraneo IdCiudad y Establece la relacion con la tabla ciudad.

    #Crear el modelo Marca
class Marca(db.Model):
    __tablename__=      'marcas'
    IdMarca =           db.Column(db.Integer, primary_key = True)
    Marca =             db.Column(db.String(45), nullable = False)
    vehiculos =         db.relationship('Vehiculo', backref='marca', lazy=True) 
    # Establece relacion entre las tablas vehiculos y marcas, así para acceder a la marca de un vehículo se usará vehiculo.marca.Marca desde la pplantilla requerida.


# Crear el modelo Tipo Carroceria
class Tipos_Carroceria(db.Model):
    __tablename__ =     'tipos_carroceria'
    IdTipoCarroceria =  db.Column(db.Integer, primary_key = True)
    TipoCarroceria =    db.Column(db.String(45), nullable = False)
    # Establece relacion entre las tablas vehiculos y tipos_carrocería, así para acceder a los tipos vehiculos de determinado tipo de carrocería.
    vehiculos = db.relationship('Vehiculo', backref='tipo_carroceria', lazy=True)  
    # Vehiculo es la clase del modelo, tipo_carrocería es el nombre de la referencia a emplear.

# Se crea el modelo ciudad:
class Ciudad(db.Model):
    __tablename__ =     'ciudades'
    IdCiudad =          db.Column(db.Integer, primary_key=True)
    Ciudad =            db.Column(db.String(45), nullable = False)
    vehiculos =         db.relationship('Vehiculo', backref='ciudad_vehiculo', lazy=True)
    # Se estabece referencia ciudad_vehiculo con la tabla vehiculos para usarla en el front


# Se crea el modelo Ordenes de Servicio
class Orden(db.Model):
   __tablename__ = 'ordenes'
   IdOrden =           db.Column(db.Integer, primary_key=True)
   IdCliente =         db.Column(db.Integer, db.ForeignKey('clientes.IdCliente'), nullable = False )   
   KM_Entrada =        db.Column(db.Integer, nullable = False)
   KM_Salida =         db.Column(db.Integer, nullable = True)
   FechaIngreso =      db.Column(db.DateTime, nullable = False)
   FechaFinServicio =  db.Column(db.Integer, nullable = True)
   Observaciones =     db.Column(db.String(300), nullable = True)
    ## faltan campos foraneos por definir