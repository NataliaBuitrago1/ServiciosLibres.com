import React, { useState } from 'react';
import axios from 'axios';
import './Login.css'

import email_icon from '../assets/icons/emailiconlogin.png'
import passwword_icon from '../assets/icons/pwiconlogin.png'
import servlibres_icon from '../assets/icons/servicioslibres-logo.png'

function Login() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [type, setType] = useState('Cliente');

  const [alertMessage, setAlertMessage] = useState(''); // Estado para almacenar el mensaje de la alerta

  const handleSubmit = async (event) => {
    event.preventDefault();

    try {
      const instance = axios.create({
        baseURL: 'http://127.0.0.1:5000',
        timeout: 5000,
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Headers': 'POST, GET, PUT, DELETE, OPTIONS, HEAD, Authorization, Origin, Accept, X-Requested-With, Content-Type, Access-Control-Request-Method, Access-Control-Request-Headers, Access-Control-Allow-Origin',
          'Content-Type': 'application/json',
        }
      });
      instance.post('/login', { 'email': username, 'password': password, 'type':type})
      .then(response => {
        console.log(response.data);
        let res = response.data['response'];
        if(res == "successful"){
          localStorage.setItem("auth_hash", response.data['auth_hash']);
          localStorage.setItem("type", type);
          localStorage.setItem("id", response.data['id']);
          setAlertMessage('¡Bienvenido!');
          window.alert('¡Bienvenido!');
          if(type == "Cliente"){
            window.location.replace('../Cliente'); 
          }else if(type == "Empresa"){
            window.location.replace('../Empresa'); 
          }
        }else{
          localStorage.setItem("auth_hash", "");
          setAlertMessage(res);
          window.alert(res); 
        }
        //
      });
    } catch (error) {
      console.error("Hubo un error al hacer login:", error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <div className='container'>
        <div className='header'>
          <div className='text custom-font'> Inicia Sesión </div>
          <div className='underline'></div>
          <img src={servlibres_icon} alt="" className='servlibres_icon'/>
        </div>
        <div className='inputs'>
          <div className='input'>
            <img src={email_icon} alt="" />
            <select defaultValue="Cliente" value={type} onChange={e => setType(e.target.value)} className="login-input">
              <option value="Cliente">Cliente</option>
              <option value="Empresa">Empresa</option>
            </select>
          </div>
          <div className='input'>
            <img src={email_icon} alt="" />
            <input type="text" value={username} onChange={(e) => setUsername(e.target.value)} className="login-input" placeholder="Email"/>
          </div>
          <div className='input'>
            <img src={passwword_icon} alt="" />
            <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} className="login-input" placeholder="Contraseña"/>
          </div>
          <div className='submit-container'>
            <button type="submit">Iniciar Sesión</button>
          </div>
        </div>
      </div>
    </form>
  );
}

export default Login;