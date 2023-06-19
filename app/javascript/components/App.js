import React from 'react';
import Header from './components/Header';
import Top from './pages/Top';
import Footer from './components/Footer';
import { BrowserRouter, Routes, Route } from 'react-router-dom';
import Simulation from './pages/Simulation';
import PrivacyPolicy from './pages/PrivacyPolicy';
import TermsAndCondition from './pages/TermsAndCondition';
import UserNew from './pages/users/UserNew';

const MainContent = () => {
  return (
    <BrowserRouter>
      <div className='mt-16 h-full'>
        <Routes>
          <Route path='/' element={<Top />} />
          <Route path='/simulation' element={<Simulation />} />
          <Route path='/privacypolicy' element={<PrivacyPolicy />} />
          <Route path='/termandcondition' element={<TermsAndCondition />} />
          <Route path='/user/new' element={<UserNew />} />
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
