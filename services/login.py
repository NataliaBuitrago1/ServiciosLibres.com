import random
from flask import Flask, request, jsonify
from hashlib import sha256
from db import Db
import json

app = Flask(__name__)
class Login:
    @app.route('/loginOauth', methods=['POST'])
    def loginOauth():
        data = request.json
        email = data['email']
        password = data['password']
        tipo = data['type']
        with Db.obtenerCursor() as cursor:
            cursor.execute(f"SELECT id, email, password, nonce FROM usuario WHERE email='{email}'")
            record = cursor.fetchall()
            if len(record)>0:
                print('User existe')
                nonce = record[0].nonce
                password_string = json.dumps([int(nonce), password])
                password_hash = sha256(password_string.encode()).hexdigest()
                if password_hash == record[0].password:
                    print('contraseña correcta')
                    if tipo == "Cliente":
                        cursor.execute(f"SELECT id FROM cliente WHERE usuario ='{record[0].id}'")
                        exists = cursor.fetchall()
                        if len(exists)>0:
                            return {'response': 'successful', 'id':record[0].id}
                        else:
                            return {'response': 'No existe ningun cliente registrado con ese correo'}
                    elif tipo == "Empresa":
                        cursor.execute(f"SELECT id FROM empresa WHERE usuario ='{record[0].id}'")
                        exists = cursor.fetchall()
                        if len(exists)>0:
                            return {'response': 'successful', 'id':record[0].id}
                        else:
                            return {'response': 'No existe ninguna empresa registrado con ese correo'}
                else:
                    print('contraseña incorrecta')
                    return {'response': 'error wrong password'}
            else:
                return {'response': 'email not registered'}
    
    @app.route('/updateAuth', methods=['POST'])
    def updateAuth():
        data = request.json
        id = data['id']
        auth_string = ''
        for i in range(3):
            auth_string = f"{auth_string}{random.randint((2000+i), 9999)}"
        auth_hash = sha256(auth_string.encode()).hexdigest()
        with Db.obtenerCursor() as cursor:
            cursor.execute(f"UPDATE usuario SET oauth='{auth_hash}' WHERE id={id}")
            return {'auth_hash':auth_hash}



    @app.route('/getAuth', methods=['POST'])
    def getAuth():
        data = request.json
        id = data['id']
        pass

if __name__ == '__main__':
    app.run(debug=True, port=5003)