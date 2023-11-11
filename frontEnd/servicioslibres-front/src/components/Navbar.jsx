import React, { useState } from 'react';
import { Link } from 'react-router-dom';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faBars, faTimes } from '@fortawesome/free-solid-svg-icons';
import './Navbar.css';

import servlibres_icon2 from '../assets/icons/servicioslibres-logo2.png';
import { Button } from './Button';

function Navbar() {
    const [click, setClick] = useState(false);
    const [button, setButton] = useState(true);

    const handleClick = () => setClick(!click);
    const closeMobileMenu = () => setClick(false);

    const showButton = () => {
        if (window.innerWidth <= 960) {
            setButton(false)
        } else {
            setButton(true)
        }
    };

    window.addEventListener('resize', showButton);

    return (
        <>
            <nav className="navbar">
                <div className="navbar-container">
                    <Link to="/" className='nav-links' onClick={closeMobileMenu}>
                        <img src={servlibres_icon2} alt="" className='servlibres_icon2' />
                    </Link>
                    <div className="menu-icon" onClick={handleClick}>
                        <FontAwesomeIcon icon={click ? faTimes : faBars} />
                    </div>
                    <ul className={click ? 'nav-menu active' : 'nav-menu'}>
                        <li className='nav-item'>
                            <Link to="/login" className='nav-links' onClick={closeMobileMenu}>
                                Ingresa
                            </Link>
                        </li>
                        <li className='nav-item'>
                            <Link to="/about" className='nav-links' onClick={closeMobileMenu}>
                                Sobre Nosotros
                            </Link>
                        </li>
                    </ul>
                    {button && <Button buttonStyle='btn--outline'>Regístrate</Button>}
                </div>
            </nav>
        </>
    )
}

export default Navbar;
