require 'rails_helper'

RSpec.describe "Simulations", type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  let(:result){ build(:result, child: child) }
  describe 'Result' do
    context 'with all attributes' do
      before do
        login(user)
        click_on '積立計画'
        click_on '教育費シュミレーション'

        find("option[value='#{result.age}才']").select_option
        within '.form-nursery_school-group' do
          find('label', text: '私立').click
        end
        within '.form-kindergarten-group' do
          find('label', text: '私立').click
        end
        within '.form-primary_school-group' do
          find('label', text: '公立').click
        end
        within '.form-junior_high_school-group' do
          find('label', text: '公立').click
        end
        within '.form-high_school-group' do
          find('label', text: '私立').click
        end
        within '.form-university-group' do
          find('label', text: '私立理系').click
        end
        find("option[value='#{result.living_alone_funds}万円']").select_option
        click_button 'シュミレーション結果'
      end
      it 'is successful' do
        expect(current_path).to eq simulation_result_path  # シュミレーション結果画面への遷移を確認
        expect(page).to have_content "#{result.age}〜18才まで" # 積立期間が表示されること
        expect(page).to have_content '総額： 22,015,376円' # 積立総額が表示されること
        expect(page).to have_content '月額　約101,923円' # 月額の積立金額が表示されること
        expect(page).to have_selector 'canvas' # グラフが表示されること
      end
    end
  end 
end
