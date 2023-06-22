require 'rails_helper'

RSpec.describe "Users", type: :system do
  describe 'before log in,' do
    describe 'Sign in' do
      context 'with all attributes' do
        before do
          visit new_user_path
          fill_in 'ユーザー名', with: 'Test_1'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          check '利用規約とプライバシーポリシーに同意する'

          click_button '確認画面へ'

          click_button '登録する'
        end
        it 'is successful' do
          expect(current_path).to eq users_complete_path
          expect(page).to have_content '会員登録が完了しました'
        end
      end

      context 'without name' do
        before do
          visit new_user_path
          # nameの入力をしない
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          check '利用規約とプライバシーポリシーに同意する'

          click_button '確認画面へ'
        end
        it 'is failed' do
          expect(page).to have_content 'Nameを入力してください'
        end
      end

      context 'with duplicated name' do
        let!(:duplicated_user){ create(:user, name: 'Test_1') }
        before do
          visit new_user_path
          fill_in 'ユーザー名', with: 'Test_1'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          check '利用規約とプライバシーポリシーに同意する'

          click_button '確認画面へ'
        end
        it 'is failed' do
          expect(page).to have_content 'そのユーザー名は使用されています'
        end
      end
    end
  end
end
