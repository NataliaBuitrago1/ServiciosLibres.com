from flask import Flask, request, jsonify
import requests
from flask_cors import CORS
import json

app = Flask(__name__)
CORS(app)

class MiddleUser:
    def __init__(self):
        print("middleWare usuario serviciosLibres.com: ON")

    @app.route('/login', methods=['POST'])
    def login():
        print(request)
        data = request.json
        print(data)
        email = data['email']
        password = data['password']
        tipo = str(data['type'])
        data = {
            'email':email,
            'password':password,
            'type':tipo,
        }
        if tipo =='Cliente':
            response = requests.post('http://127.0.0.1:5003/loginOauth', json=data)
            if response.json()['response'] == 'successful':
                id = response.json()['id']
                data = {
                    'id':id
                }
                response = requests.post('http://127.0.0.1:5003/updateAuth', json=data)
                return {'response': 'successful','auth_hash':response.json()['auth_hash'],'id':id}
            else:
                return response.json()
        if tipo =='Empresa':
            response = requests.post('http://127.0.0.1:5003/loginOauth', json=data)
            if response.json()['response'] == 'successful':
                id = response.json()['id']
                data = {
                    'id':id
                }
                response = requests.post('http://127.0.0.1:5003/updateAuth', json=data)
                return {'response': 'successful','auth_hash':response.json()['auth_hash'],'id':id}
            else:
                return response.json()
    
    @app.route('/signInCliente', methods=['POST'])
    def signInCliente():
        data = request.json
        if str(data['type']) =='Cliente':
            data = {
                'email':data['email'],
                'password':data['password'],
                'direccion':data['direccion'],
                'telefono':data['telefono'],
                'tipo_doc':data['tipo_doc'],
                'no_documento':data['no_documento'],
                'nombres':data['nombres'],
                'apellidos':data['apellidos'],
            }
            response = requests.post('http://127.0.0.1:5004/signIn', json=data)
            if response.json()['response'] == 'successful':
                id = response.json()['id']
                data = {
                    'id':id
                }
                response = requests.post('http://127.0.0.1:5003/updateAuth', json=data)
                return {'response': 'successful','auth_hash':response.json()['auth_hash'],'id':id}
            else:

                return response.json()
        elif data['tipo'] =='empresa':
            return {'response': 'We are working in this function'}

    @app.route('/signInEmpresa', methods=['POST'])
    def signInEmpresa():
        data = request.json
        if str(data['type']) =='Empresa':
            data = {
                'email':data['email'],
                'password':data['password'],
                'direccion':data['direccion'],
                'telefono':data['telefono'],
                'nit':data['nit'],
                'dv':data['dv'],
                'razon_social':data['razon_social'],
                'descripcion':data['descripcion'],
            }
            response = requests.post('http://127.0.0.1:5005/signIn', json=data)
            if response.json()['response'] == 'successful':
                id = response.json()['id']
                data = {
                    'id':id
                }
                response = requests.post('http://127.0.0.1:5001/updateAuth', json=data)
                return {'response': 'successful','auth_hash':response.json()['auth_hash'],'id':id}
            else:
                return response.json()
        elif data['tipo'] =='empresa':
            return {'response': 'We are working in this function'}
        
if __name__ == '__main__':
    app.run(debug=True, port=5000)