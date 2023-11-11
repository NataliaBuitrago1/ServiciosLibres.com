import React from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import './index.css';
import Landing from './initialspages/Landing';
import Signin from './initialspages/Signin';
import Login from './initialspages/Login';
import Navbar from './components/Navbar';
import About from './initialspages/About';
import Footer from './components/Footer';

ReactDOM.createRoot(document.getElementById('root')).render(
  
  <BrowserRouter> 
    <Navbar />
    <Routes>
      <Route path="/" element={<Landing />} />
      <Route path="/signin" element={<Signin />} />
      <Route path="/login" element={<Login />} />
      <Route path="/about" element={<About />} />
    </Routes>
    <Footer />
  </BrowserRouter>
);



export default App
