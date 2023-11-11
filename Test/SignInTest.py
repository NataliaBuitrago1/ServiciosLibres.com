import requests

class SignInTest:

    def testLogin(self):
        data = {
            'tipo':'cliente',
            'email':'prueba7@prueba.com',
            'password':'1234543asw',
            'direccion':'Calle 5sur # 86b-50',
            'telefono':'3226789898',
            'tipo_doc':'1',
            'no_documento':'1030674465',
            'nombres':'Pepitor',
            'apellidos':'Perezm', 
            }
        print(data)
        response = requests.post('http://127.0.0.1:5000/signIn', json=data)
        print(response.json())


test = SignInTest()
test.testLogin()