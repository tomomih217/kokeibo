import React from 'react';
import Header from './components/Header';
import Top from './pages/Top';
import Footer from './components/Footer';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

const MainContent = () => {
  return (
    <BrowserRouter>
      <div className='mt-16 h-5/6'>
        <Routes>
          <Route path='/' element={<Top />} />
        </Routes>
      </div>
    </BrowserRouter>

  )
};

const App = () => {
  return (
    <div className='w-full h-screen absolute bg-amber-light top-0'>
      <Header />
      <MainContent />
      <Footer />
    </div>
  )
};

export default App;
