import React from 'react';
import json from '../../../../public/education_cost.json';
import WithoutTitleCard from '../components/WithoutTitleCard';
import Text from '../components/Text';
import ResultGraph from './ResultGraph';

const Result = ({ props }) => {
  //積立期間
  const duration = (18 - props.age) * 12

  //積立総額
  let costArray = [];
  const nurserySchoolCost =
    props.nurserySchool === 'public' 
      ? json.nurserySchool.public.age1 + json.nurserySchool.public.age2 
      : json.nurserySchool.private.age1 + json.nurserySchool.private.age2;
  costArray.push(nurserySchoolCost);

  const kindergartenCost =
    props.kindergarten === 'public' 
      ? json.kindergarten.public.age3 + json.kindergarten.public.age4 + json.kindergarten.public.age5
      : json.kindergarten.private.age3 + json.kindergarten.private.age4 + json.kindergarten.private.age5;
  costArray.push(kindergartenCost);

  const primarySchoolCost =
    props.primarySchool === 'public'
      ? json.primarySchool.public.age6 + json.primarySchool.public.age7 + json.primarySchool.public.age8 + json.primarySchool.public.age9 + json.primarySchool.public.age10 + json.primarySchool.public.age11
      : json.primarySchool.private.age6 + json.primarySchool.private.age7 + json.primarySchool.private.age8 + json.primarySchool.private.age9 + json.primarySchool.private.age10 + json.primarySchool.private.age11;
  costArray.push(primarySchoolCost);

  const juniorHighSchoolCost =
    props.juniorHighSchool === 'public'
      ? json.juniorHighSchool.public.age12 + json.juniorHighSchool.public.age13 + json.juniorHighSchool.public.age14
      : json.juniorHighSchool.private.age12 + json.juniorHighSchool.private.age13 + json.juniorHighSchool.private.age14;
  costArray.push(juniorHighSchoolCost);

  const highSchoolCost =
    props.highSchool == 'public'
      ? json.highSchool.public.age15 + json.highSchool.public.age16 + json.highSchool.public.age17
      : json.highSchool.private.age15 + json.highSchool.private.age16 + json.highSchool.private.age17;
  costArray.push(highSchoolCost);

  let universityCost = 0;
  if ( props.university === 'publicArts' ) {
    universityCost = json.university.publicArts.age18 + json.university.publicArts.age19 + json.university.publicArts.age20 + json.university.publicArts.age21;
  } else if ( props.university === 'publicScience' ) {
    universityCost = json.university.publicScience.age18 + json.university.publicScience.age19 + json.university.publicScience.age20 + json.university.publicScience.age21;
  } else if ( props.university === 'privateArts' ) {
    universityCost = json.university.privateArts.age18 + json.university.privateArts.age19 + json.university.privateArts.age20 + json.university.privateArts.age21;
  } else if ( props.university === 'privateScience' ) {
    universityCost = json.university.privateScience.age18 + json.university.privateScience.age19 + json.university.privateScience.age20 + json.university.privateScience.age21;
  }
  costArray.push(universityCost);

  let livingAloneCost;
  if (props.livingAloneFunds > 0) {
    livingAloneCost = json.livingAllowance.initialize + livingAloneFunds * 12 * 4;
  } else {
    livingAloneCost = 0;
  }
  costArray.push(livingAloneCost);

  const amount = costArray.reduce(function(a,b){
    return a + b;
  })
  const formattedAmount = amount.toLocaleString();

  //月々の積立金額
  const monthlyAmount = Math.round(amount / duration);
  const formattedMonthlyAmount = monthlyAmount.toLocaleString();

  return (
    <div>
      <WithoutTitleCard widthSize='1/2' bgColor='blue-100' borderColor='blue-500'>
        <div>
          <Text size='lg' color='amber-dark' style='mb-3'>{props.age}〜18才まで　{duration}ヶ月</Text>
          <Text size='3xl' color='amber-dark' style='mb-3'>総額： {formattedAmount}円</Text>
          <Text size='lg' color='amber-dark'>月額　約{formattedMonthlyAmount}円</Text>
        </div>
      </WithoutTitleCard>

      <div className='w-1/2 m-auto'>
        <ResultGraph monthlyAmount={monthlyAmount} costArray={costArray} />
      </div>

      <div className='mt-3'>
        <Text size='xs' color='amber-dark'>
          『令和3年度子供の学習費調査の結果について（文部科学省より・令和4年12月発行）』
        </Text>
        <Text size='xs' color='amber-dark'>
          『令和3年度「教育費負担の実態調査結果」（日本政策金融公庫より・令和3年12月発行）』
        </Text>
      </div>

    </div>
  );
}

export default Result;
