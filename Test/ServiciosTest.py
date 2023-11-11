import requests

class ServiciosTest:

    def testLogin(self):
        data = {
            'tipo_servicio':'1'
        }
        print(data)
        response = requests.post('http://127.0.0.1:5000/getServices', json=data)
        print(response.json())


test = ServiciosTest()
test.testLogin()