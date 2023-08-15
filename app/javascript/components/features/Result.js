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

  //教育費算出
  //costArrayはグラフに渡す、３年ごとの教育費累計額を格納した配列
  //costDatasは年齢別に教育費を格納した配列
  const SchoolTypes = [
    {type: 'nurserySchool', age: 6, term: ['age1', 'age2', 'age3', 'age4', 'age5']},
    {type: 'kindergarten', age: 6, term: ['age3', 'age4', 'age5']},
    {type: 'primarySchool', age: 12, term: ['age6', 'age7', 'age8', 'age9', 'age10', 'age11']},
    {type: 'juniorHighSchool', age: 15, term: ['age12', 'age13', 'age14']},
    {type: 'highSchool', age: 18, term: ['age15', 'age16', 'age17']},
    {type: 'university', age: 22, term: ['age18', 'age19', 'age20', 'age21'],}
  ]

  const costDatas = [0];
  const costArray = [0];
  let total = 0;
  SchoolTypes.forEach((school) => {
    if (props[school.type] !== 'unselected'){
      if (props.age < school.age){
        const categoryKey = props[school.type];
        const publicOrPrivate = json[school.type][categoryKey];

        let ageRange;
        if (school.type === 'nurserySchool' && props['kindergarten'] !== 'unselected'){
          if (props.entryage === '1'){
            ageRange = ['age1', 'age2']
          } else if (props.entryage === '2'){
            ageRange = ['age2']
          } else {
            ageRange = []
          }
        } else if (school.type === 'kindergarten' && props['kindergarten'] === 'unselected'){
          ageRange = [];
        } else {
          ageRange = school.term
        }

        ageRange.forEach((age) => {
          let livingAloneCost = 0;
          if (school.type === 'university' && props.livingAloneFunds !== 0){
            age === 'age18'
            ? livingAloneCost = publicOrPrivate[age] + props.livingAloneFunds * 12 + json['livingAllowance']['initialize']
            : livingAloneCost = publicOrPrivate[age] + props.livingAloneFunds * 12;
          }
          const cost = publicOrPrivate[age] + livingAloneCost;
          if ((parseInt(age.slice(3), 10) + 1) % 3 === 0 && parseInt(age.slice(3), 10) !== 20){
            total += cost;
            costArray.push(total)
          } else if (parseInt(age.slice(3)) === 21){
            total += cost;
            costArray.push(total)
          } else {
            total += cost;
          }
          costDatas.push(cost);
        })
      } else {
        for(let i = 0; i < school.term.length; i++){
          if (school.type !== 'kindergarten'){
            costDatas.push(0);
            const eachAge = parseInt(school.term[i].slice(3), 10);
            if ((eachAge + 1) % 3 === 0 && eachAge !== 20){
              costArray.push(0);
            } else if (eachAge === 21) {
              costArray.push(0);
            }
          }
        }
      }
    } else {
      if (school.type === 'nurserySchool') {
        costArray.push(0);
        Array.from({ length: 2 }, (_, index) => {
          costDatas.push(0);
        })
      }
    }
  })

  //教育費の総額
  const amount = costDatas.reduce(function(a,b){
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
      <div className='mt-10'>
        <p className='text-center text-amber-dark'>会員登録をして、教育費を貯めましょう。</p>
        <Link page='/users/new'>
          <Button pxSize='3' pySize='2' color='green-300' fontColor='white' roundType='full'>会員登録（無料）</Button>
        </Link>
      </div>
    </div>
  );
}

export default Result;
