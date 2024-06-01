# Este modulo permite tener una instancia de sqlalchemy a la vez
from flask_sqlalchemy import SQLAlchemy  # Importamos librería

db = SQLAlchemy()   # creamos la instancia db para que sea importada desde los módulos que se requieran 
