import React from 'react';
import Header from './components/Header';
import Top from './pages/Top';
import Footer from './components/Footer';
import WithoutTitleCard from './components/WithoutTitleCard';

const MainContent = () => {
  return (
    <div className='mt-16 h-5/6'>
      <Top />
      <WithoutTitleCard>カード挿入</WithoutTitleCard>
    </div>
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
