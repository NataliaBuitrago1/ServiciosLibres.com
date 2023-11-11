import random
from flask import Flask, request, jsonify
from hashlib import sha256
from db import Db
import json

app = Flask(__name__)
class Cliente:
    @app.route('/signIn', methods=['POST'])
    def signIn():
        data = request.json
        with Db.obtenerCursor() as cursor:
            cursor.execute(f"SELECT id, email, password, nonce FROM usuario WHERE email='{data['email']}'")
            records = cursor.fetchall()
            print(len(records))
            if len(records)>0:
                return {'response': 'There is a user registered with this email'}
            else:
                cursor.execute(f"SELECT tipo_doc, no_documento FROM cliente WHERE no_documento='{data['no_documento']}' AND tipo_doc='{data['tipo_doc']}'")
                records = cursor.fetchall()
                print(len(records))
                if len(records)>0:
                    return {'response': 'There is a user registered with document'}
                else:
                    nonce = 1
                    password = data['password']
                    password_string = json.dumps([nonce, password])
                    password_hash = sha256(password_string.encode()).hexdigest()
                    while password_hash[:2] != '42':
                        nonce += 1
                        password_string = json.dumps([nonce, password])
                        password_hash = sha256(password_string.encode()).hexdigest()
                    print(nonce)
                    print(password_hash)
                    try:
                        cursor.execute(f"INSERT INTO usuario (email, password, direccion, telefono, nonce, oauth, activo) VALUES ('{data['email']}', '{password_hash}', '{data['direccion']}', '{data['telefono']}', '{nonce}', '0', 1)")
                        cursor.execute(f"SELECT id FROM usuario WHERE email='{data['email']}'")
                        record = cursor.fetchone()
                        id_user = record.id
                        cursor.execute(f"INSERT INTO cliente (no_documento, nombres, apellidos, tipo_doc, usuario) VALUES ('{data['no_documento']}', '{data['nombres']}', '{data['apellidos']}', {data['tipo_doc']}, {id_user})") 
                        return {'response': 'successful', 'id':id_user}
                    except Exception as e:
                        return {'response': 'Happen a error when we tried to create your user'}
                    

if __name__ == '__main__':
    app.run(debug=True, port=5005)