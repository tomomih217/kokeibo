import React from 'react';
import json from '../../../../public/education_cost.json';
import WithoutTitleCard from '../components/WithoutTitleCard';
import Text from '../components/Text';

const Result = ({ age, nurserySchool, kindergarten, primarySchool, juniorHighSchool, highSchool, university, livingAloneFunds }) => {
  //積立期間
  const duration = (18 - age) * 12

  //積立総額
  const nurserySchoolCost =
    nurserySchool === 'public' ? json.nurserySchool.public : json.nurserySchool.private;

  const kindergartenCost =
    kindergarten === 'public' ? json.kindergarten.public : json.kindergarten.private;

  const primarySchoolCost =
    primarySchool === 'public' ? json.primarySchool.public : json.primarySchool.private;

  const juniorHighSchoolCost =
    juniorHighSchool === 'public' ? json.juniorHighSchool.public : json.juniorHighSchool.private;

  const highSchoolCost =
    highSchool == 'public' ? json.highSchool.public : json.highSchool.private;

  let universityCost;
  if ( university === 'publicArts' ) {
    universityCost = json.university.publicArts;
  } else if ( university === 'publicScience' ) {
    universityCost = json.university.publicScience;
  } else if ( university === 'privateArts' ) {
    universityCost = json.university.privateArts;
  } else if ( university === 'privateScience' ) {
    universityCost = json.university.privateScience;
  } else {
    universityCost = 0;
  }

  const amount = nurserySchoolCost + kindergartenCost + primarySchoolCost + juniorHighSchoolCost + highSchoolCost + universityCost;
  const formattedAmount = amount.toLocaleString();

  //月々の積立金額
  const monthlyAmount = amount / duration;
  const formattedMonthlyAmount = Math.round(monthlyAmount).toLocaleString();

  return (
    <div>
      <WithoutTitleCard widthSize='1/2'>
        <div className='m-auto'>
          <Text size='lg' color='amber-dark' style='mb-3'>{age}〜18才まで　{duration}ヶ月</Text>
          <Text size='3xl' color='amber-dark' style='mb-3'>総額： {formattedAmount}円</Text>
          <Text size='lg' color='amber-dark'>月額　約{formattedMonthlyAmount}円</Text>
        </div>
      </WithoutTitleCard>
    </div>
  );
}

export default Result;
