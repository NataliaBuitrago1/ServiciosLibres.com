import requests

class LoginTest:

    def testLogin(self):
        data = {
            'email':'prueba7@prueba.com',
            'password':'1234543asw'
        }
        print(data)
        response = requests.post('http://127.0.0.1:5000/login', json=data)
        print(response.json())


test = LoginTest()
test.testLogin()