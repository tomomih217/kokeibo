require 'rails_helper'

RSpec.describe "Simulations", type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  before { login(user) }
  describe 'Result' do
    describe 'create' do
      let(:result){ build(:result, child: child) }
      before { click_on '希望進路を登録する' }
      context 'with all attributes' do
        before do
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
          click_button '登録する'
        end
        it 'is successful' do
          expect(page).to have_content '希望進路を登録しました'
          expect(current_path).to eq mypage_path
        end
      end
    end
    
    describe 'update' do
      describe 'create' do
        let!(:result){ create(:result, child: child) }
        before { visit edit_simulation_path(result) }
        context 'with all attributes' do
          before do
            within '.form-high_school-group' do
              find('label', text: '公立').click
            end
            click_button 'シュミレーション結果'
            click_button '編集する'
          end
          it 'is successful' do
            expect(page).to have_content '希望進路を編集しました'
            expect(current_path).to eq child_results_path(child)
          end
        end
    end
  end
  
  describe 'index' do
    context 'without registerd result' do
      before { visit child_results_path(child) }
      it 'has button to link to simulation#new' do
        expect(page).to have_content 'データはありません'
        expect(page).to have_link '希望進路の登録', href: new_child_simulation_path(child)
      end
    end
    fcontext 'with registerd result' do
      let!(:result){ create(:result, child: child) }
      before { visit child_results_path(child) }
      it 'has button to link to simulation#edit' do
        expect(page).to have_content result.age
        expect(page).to have_content '保育園: 私立'
        expect(page).to have_content '幼稚園: 私立'
        expect(page).to have_content '小学校: 公立'
        expect(page).to have_content '中学校: 公立'
        expect(page).to have_content '高校: 私立'
        expect(page).to have_content '大学: 私立理系'
        expect(page).to have_content (result.living_alone_funds * 10000).to_s(:delimited)
        expect(page).to have_link '希望進路の変更'
      end
    end
  end

  describe 'new' do
    let(:result){ build(:result, child: child) }
    before { click_on '希望進路を登録する' }
    context 'with all attributes' do
      before do
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
        expect(current_path).to eq child_result_path(child) # シュミレーション結果画面への遷移を確認
        expect(page).to have_content "#{result.age}〜18才まで" # 積立期間が表示されること
        expect(page).to have_content '総額： 22,015,376円' # 積立総額が表示されること
        expect(page).to have_content '月額　約101,923円' # 月額の積立金額が表示されること
        expect(page).to have_selector 'canvas' # グラフが表示されること
      end
    end
    context 'without age' do
      before do
        # ageを選択しない
        # find("option[value='#{result.age}才']").select_option
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
      it 'is failed' do
        expect(page).to have_content '教育費シュミレーション'
        expect(page).to have_content '年齢を選択してください'
      end
    end
    context 'without a clicked button' do
      before do
        find("option[value='#{result.age}才']").select_option
        # 保育園を選択しない
        # within '.form-nursery_school-group' do
        #   find('label', text: '私立').click
        # end
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
      it 'is failed' do
        expect(page).to have_content '教育費シュミレーション'
        expect(page).to have_content '保育園を選択してください'
      end
    end
    context 'without selected living_alone_fund' do
      before do
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
        # 仕送り金額を選択しない
        # find("option[value='#{result.living_alone_funds}万円']").select_option
        click_button 'シュミレーション結果'
      end
      it 'is failed' do
        expect(page).to have_content '教育費シュミレーション'
        expect(page).to have_content '仕送り金額を選択してください'
      end
    end
  end

  describe 'edit' do
    let!(:result){ create(:result, child: child) }
    before { visit edit_simulation_path(result) }
    context 'with registerd result content' do
      it 'can be displayed' do
        expect(page).to have_field 'result[age]' with: result.age
        within '.form-nursery_school-group' do
          expect(page).to have_checked_field 'private'
        end
        within '.form-kindergarten-group' do
          expect(page).to have_checked_field 'private'
        end
        within '.form-primary_school-group' do
          expect(page).to have_checked_field 'public'
        end
        within '.form-junior_high_school-group' do
          expect(page).to have_checked_field 'public'
        end
        within '.form-high_school-group' do
          expect(page).to have_checked_field 'private'
        end
        within '.form-university-group' do
          expect(page).to have_checked_field 'privateScience'
        end
        expect(page).to have_field 'result[living_alone_funds]', with: result.living_alone_funds
      end
    end
    context 'with all attributes' do
      before do
        within '.form-high_school-group' do
          find('label', text: '公立').click
        end
        click_button 'シュミレーション結果'
      end
      it 'is successful' do
        expect(current_path).to eq child_result_path(child) # シュミレーション結果画面への遷移を確認
        expect(page).to have_content "#{result.age}〜18才まで" # 積立期間が表示されること
        expect(page).to have_content '総額： 17.072,091円' # 積立総額が表示されること
        expect(page).to have_content '月額　約79,037円' # 月額の積立金額が表示されること
        expect(page).to have_selector 'canvas' # グラフが表示されること
      end
    end
    context 'without age' do
      before do
        # ageを選択しない
        find("option[value='選択してください']").select_option
        click_button 'シュミレーション結果'
      end
      it 'is failed' do
        expect(page).to have_content '教育費シュミレーション'
        expect(page).to have_content '年齢を選択してください'
      end
    end
    context 'without selected living_alone_fund' do
      before do
        # 仕送り金額を選択しない
        find("option[value='選択してください']").select_option
        click_button 'シュミレーション結果'
      end
      it 'is failed' do
        expect(page).to have_content '教育費シュミレーション'
        expect(page).to have_content '仕送り金額を選択してください'
      end
    end
  end
end
