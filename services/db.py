import sys
import pyodbc

class Db:
    _SERVER = 'localhost'
    _DB = 'serviciosLibres'
    _USUARIO = 'loginUser'
    _CONTRASENA = 'ghgSEUL2106$'
    _conexion = None
    _cursor = None

    @classmethod
    def obtenerConexion(cls):
        if cls._conexion is None:
            try:
                cls._conexion = pyodbc.connect(
                    'DRIVER={ODBC Driver 17 for SQL server}; SERVER=' + Db._SERVER + '; DATABASE=' + Db._DB + '; UID=' + Db._USUARIO + ';PWD=' + Db._CONTRASENA + ';')
                return cls._conexion
            except Exception as e:
                print(f"ha ocurrio un error {e}")
        else:
            return cls._conexion

    @classmethod
    def obtenerCursor(cls):
        if cls._cursor is None:
            try:
                cls._cursor = cls.obtenerConexion().cursor()
                return cls._cursor
            except Exception as e:
                print(f"ha ocurrio un error {e}")
        else:
            return cls._cursor
        
    @classmethod
    def cerrarConexion(cls):
        cls._conexion.close()

if __name__ == '__main__':
    Db.obtenerConexion()
    Db.obtenerCursor()