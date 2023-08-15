import React from 'react';
import Card from '../components/Card';
import Text from '../components/Text';
import AgeSelect from './AgeSelect';
import Label from '../components/Label';
import SchoolButtons from './SchoolButtons';
import LivingAloneFundsSelectDropdown from './LivingAloneFundsSelect';
import EntryAgeSelect from './EntryageSelect';

const SimulationForm = ({ selectedValues, handleDropdownChange, schoolTypes }) => {
  return (
    <div>
      <div className='mt-5'>
        <Card widthSize='1/2 md:w-2/3' title='STEP1'>
          <div className='py-5 text-center'>
            <Text size='md' color='amber-dark'>お子様のご年齢は？</Text>
            <AgeSelect identifier='age' selectedAge={selectedValues['age']} onChange={handleDropdownChange} />
          </div>
        </Card>
      </div>

      <div className='mt-10'>
        <Card widthSize='1/2 md:w-2/3' title='STEP2'>
          <div className='py-5 text-center'>
            <Text size='md' color='amber-dark'>希望進路を選択してください。</Text>
            <div className='lg:px-10 pt-8'>
              { schoolTypes.map((schoolType, index) => {
                const selectedValue = schoolType.type;
                if (schoolType.age > selectedValues['age']){
                  if (selectedValue === 'nurserySchool') {
                    return (
                      <div className='mb-5'>
                        <Label size='md' color='amber-dark'>{schoolType.label}</Label>
                        <SchoolButtons identifier={schoolType.type} selectedButton={selectedValues[selectedValue]} onChange={handleDropdownChange} />
                        <EntryAgeSelect identifier='entryage' onChange={handleDropdownChange} />
                      </div>
                    )
                  } else {
                    return (
                      <div className='mb-5'>
                        <Label size='md' color='amber-dark'>{schoolType.label}</Label>
                        <SchoolButtons identifier={schoolType.type} selectedButton={selectedValues[selectedValue]} onChange={handleDropdownChange} />
                      </div>
                    )
                  }
                }           
              }) }
            </div>
          </div>
        </Card>
      </div>

      <div className='mt-10'>
        <Card widthSize='1/2 md:w-2/3' title='STEP3'>
          <div className='py-5 text-center'>
            <Text size='md' color='amber-dark'>仕送り（自宅外通学）予定金額</Text>
            <LivingAloneFundsSelectDropdown identifier='livingAloneFunds' onChange={handleDropdownChange} />
          </div>
        </Card>
      </div>
    </div>
  );
};

export default SimulationForm;
