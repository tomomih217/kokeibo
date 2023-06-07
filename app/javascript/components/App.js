import React from 'react';
import Header from './components/Header';
import Top from './pages/Top';
import Footer from './components/Footer';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Simulation from './pages/Simulation';

const MainContent = () => {
  return (
    <BrowserRouter>
      <div className='mt-16 h-full'>
        <Routes>
          <Route path='/' element={<Top />} />
          <Route path='/simulation' element={<Simulation />} />
        </Routes>
      </div>
    </BrowserRouter>

  )
};

const App = () => {
  return (
    <div className='w-full h-full absolute bg-amber-light top-0 overflow-y-scroll relative'>
      <Header />
      <MainContent />
      <Footer />
    </div>
  )
};

export default App;
