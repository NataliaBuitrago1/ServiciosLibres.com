import random
from flask import Flask, request, jsonify
from db import Db
import json

app = Flask(__name__)
class Servicios:
    @app.route('/getServices', methods=['POST'])
    def getServices():
        data = request.json
        tipo_servicio = data['tipo_servicio']
        with Db.obtenerCursor() as cursor:
            cursor.execute(f"SELECT id, nombre, descripcion ,precio ,requisito FROM servicio WHERE tipo_servicio={tipo_servicio}")
            records = cursor.fetchall()
            servicesList = []
            for record in records:
                servicesList.append([record.id, record.nombre, record.descripcion, record.precio, record.requisito])
            response = {
                'response': 'successful',
                'servicesList': servicesList
            }
            return response
        

if __name__ == '__main__':
    app.run(debug=True, port=5006)