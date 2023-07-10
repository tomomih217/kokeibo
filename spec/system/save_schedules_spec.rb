require 'rails_helper'

RSpec.describe "SaveSchedules", type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  describe 'Create' do
    let(:save_schedule){ create(:save_schedule, child: child ) }
    fcontext 'with all attributes' do
      before do
        login(user)
        click_on '積立計画'

        select save_schedule.age_from, from: 'save_schedule_form[save_schedules_attributes][0][age_from]'
        select save_schedule.age_to, from: 'save_schedule_form[save_schedules_attributes][0][age_to]'
        select save_schedule.amount, from: 'save_schedule_form[save_schedules_attributes][0][amount]'
        click_button '保存'
      end
      it 'is successfull' do
        expect(page).to have_content '積立計画を登録しました'
      end
    end
    context 'without term' do
      it 'is failed' do
      end
    end
    context 'without amount' do
      it 'is failed' do
      end
    end
  end
end
