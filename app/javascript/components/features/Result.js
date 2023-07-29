import React from 'react';
import json from '../../../../public/education_cost.json';
import WithoutTitleCard from '../components/WithoutTitleCard';
import Text from '../components/Text';
import ResultGraph from './ResultGraph';
import Link from '../components/Link';
import Button from '../components/Button';

const Result = ({ props }) => {
  //積立期間
  const duration = (18 - props.age) * 12

  //積立総額
  let costArray = [];
  const caluculateCost = (schoolType, ageRange) => {
    const categoryKey = props[schoolType];
    const publicOrPrivate = json[schoolType][categoryKey];

    let totalCost = 0;

    ageRange.forEach((age) => {
      const ageCost = publicOrPrivate[age];
      totalCost += ageCost;
    });

    costArray.push(totalCost);
  }

  caluculateCost("nurserySchool", ["age1", "age2"]);
  caluculateCost("kindergarten", ["age3", "age4", "age5"]);
  caluculateCost("primarySchool", ["age6", "age7", "age8", "age9", "age10", "age11"]);
  caluculateCost("juniorHighSchool", ["age12", "age13", "age14"]);
  caluculateCost("highSchool", ["age15", "age16", "age17"]);
  caluculateCost("university", ["age18", "age19", "age20", "age21"]);

  let livingAloneCost;
  if (props.livingAloneFunds > 0) {
    livingAloneCost = json.livingAllowance.initialize + props.livingAloneFunds * 12 * 4;
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
        <ResultGraph monthlyAmount={monthlyAmount} age={props.age} costArray={costArray} />
      </div>

      <div className='mt-3'>
        <Text size='xs' color='amber-dark'>
          『令和3年度子供の学習費調査の結果について（文部科学省より・令和4年12月発行）』
        </Text>
        <Text size='xs' color='amber-dark'>
          『令和3年度「教育費負担の実態調査結果」（日本政策金融公庫より・令和3年12月発行）』
        </Text>
      </div>
      <div class='mt-10'>
        <p class='text-center text-amber-dark'>会員登録をして、教育費を貯めましょう。</p>
        <Link page='/users/new'>
          <Button pxSize='3' pySize='2' color='green-300' fontColor='white' roundType='full'>会員登録（無料）</Button>
        </Link>
      </div>
    </div>
  );
}

export default Result;
