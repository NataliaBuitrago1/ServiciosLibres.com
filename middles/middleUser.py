from flask import Flask, request, jsonify
import requests
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)

class MiddleUser:
    def __init__(self):
        print("middleWare usuario serviciosLibres.com: ON")

    @app.route('/getServicesWithOutFilters', methods=['GET'])
    def getServices():
        data = {
            'filter': 'none',
        }
        response = requests.post('http://127.0.0.1:5002/getServices', json=data)
        return response.json()

        
if __name__ == '__main__':
    app.run(debug=True, port=5002)