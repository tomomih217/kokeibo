import React from 'react';
import json from '../../../../public/education_cost.json';

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

  //月々の積立金額
  const monthlyAmount = amount / duration;

  return (
    <div>
      <p>duration: {duration}ヶ月</p>
      <p>amount: {amount}円</p>
      <p>monthlyAmount: {monthlyAmount}円</p>
    </div>
  );
}

export default Result;
