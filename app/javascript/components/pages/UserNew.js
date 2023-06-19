import React from 'react';
import Container from '../components/Container';
import Card from '../components/Card';

const UserNew = () => {
  return (
    <div>
      <Container title='会員登録'>
        <div className='mt-5'>
          <Card title='登録フォーム' widthSize='1/2'>
            <div></div>
          </Card>
        </div>
      </Container>
    </div>
  );
};

export default UserNew;
