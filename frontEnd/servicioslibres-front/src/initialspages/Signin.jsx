import React, { useState } from 'react';
import axios from 'axios';
import './Signin.css'

import servlibres_icon from '../assets/icons/servicioslibres-logo.png'

function Signin() {
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [direccion, setDireccion] = useState('');
  const [telefono, setTelefono] = useState('');
  const [tipo_doc, setTipo_doc] = useState('');
  const [no_documento, setNo_documento] = useState('');
  const [nombres, setNombres] = useState('');
  const [apellidos, setApellidos] = useState('');
  const [type, setType] = useState('Cliente');

  const [alertMessage, setAlertMessage] = useState(''); // Estado para almacenar el mensaje de la alerta

  const validateForm = () => {
    // Validar el email
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    if (!emailRegex.test(username)) {
      alert('El email no es válido');
      return false;
    }

    // Validar la contraseña
    if (password.length < 8) {
      alert('La contraseña debe tener al menos 8 caracteres');
      return false;
    }

    // Validar el teléfono
    const phoneRegex = /^\d{10}$/;
    if (!phoneRegex.test(telefono)) {
      alert('El teléfono debe contener 10 números');
      return false;
    }

    return true; // Si todas las validaciones pasan
  };

  const handleSubmit = async (event) => {
    event.preventDefault();

    if (!validateForm()) {
      return;
    }

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
      instance.post('/signIn', {
        'email': username,
        'password': password,
        'tipo': 'cliente',
        'direccion': direccion,
        'telefono': telefono,
        'tipo_doc': tipo_doc,
        'no_documento': no_documento,
        'nombres': nombres,
        'apellidos': apellidos,
      })
        .then(response => {
          console.log(response.data);
          setAlertMessage('¡Registro exitoso!');
          window.alert('Usuario registrado exitosamente'); 
          window.location.replace('../index'); 
        });
    } catch (error) {
      console.error("Hubo un error al registrarse:", error);

      // Mostrar una alerta de error
      setAlertMessage('Hubo un error al registrarse. Inténtalo de nuevo más tarde.');
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <div className='container'>
        <div className='header'>
          <div className='text custom-font'> Regístrate </div>
          <div className='underline'></div>
          <img src={servlibres_icon} alt="" className='servlibres_icon' />
        </div>
        
        <div className='inputs'>
          <select defaultValue="Cliente" value={type} onChange={e => setType(e.target.value)} className="signin-input">
              <option value="Cliente">Cliente</option>
              <option value="Empresa">Empresa</option>
          </select>
          <input type="text" value={username} onChange={(e) => setUsername(e.target.value)} className="signin-input" placeholder="Email" />

          <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} className="signin-input" placeholder="Contraseña" />

          <input type="text" value={direccion} onChange={(e) => setDireccion(e.target.value)} className="signin-input" placeholder="Dirección" />

          <input type="text" value={telefono} onChange={(e) => setTelefono(e.target.value)} className="signin-input" placeholder="Teléfono" />

          <input type="text" value={tipo_doc} onChange={(e) => setTipo_doc(e.target.value)} className="signin-input" placeholder="Tipo de documento" />

          <input type="text" value={no_documento} onChange={(e) => setNo_documento(e.target.value)} className="signin-input" placeholder="Número de documento" />

          <input type="text" value={nombres} onChange={(e) => setNombres(e.target.value)} className="signin-input" placeholder="Nombres" />

          <input type="text" value={apellidos} onChange={(e) => setApellidos(e.target.value)} className="signin-input" placeholder="Apellidos" />

          <div className='submit-container'>
            <button type="submit">Registrarse</button>
          </div>
        </div>
      </div>
    </form>
  );
}

export default Signin;