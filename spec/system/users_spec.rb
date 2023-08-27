require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'before log in,' do
    describe 'Sign in' do
      context 'with all attributes' do
        before do
          visit new_user_path
          fill_in 'ユーザー名', with: 'Test_1'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          fill_in 'お子様のお名前', with: 'child_1'
          select '出産前', from: '学年'
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

      context 'without password' do
        before do
          visit new_user_path
          fill_in 'ユーザー名', with: 'Test_1'
          # パスワードを入力しない
          fill_in 'パスワード（確認用）', with: 'password'
          check '利用規約とプライバシーポリシーに同意する'

          click_button '確認画面へ'
        end
        it 'is failed' do
          expect(page).to have_content 'Password confirmationとPasswordの入力が一致しません'
          expect(page).to have_content 'Passwordを入力してください'
        end
      end

      context 'without password_confirmation' do
        before do
          visit new_user_path
          fill_in 'ユーザー名', with: 'Test_1'
          fill_in 'パスワード', with: 'password'
          # パスワード（確認用）を入力しない
          # fill_in 'パスワード（確認用）', with: 'password'
          check '利用規約とプライバシーポリシーに同意する'

          click_button '確認画面へ'
        end
        it 'is failed' do
          expect(page).to have_content 'Password confirmationとPasswordの入力が一致しません'
          expect(page).to have_content 'Password confirmationを入力してください'
        end
      end

      context 'without checkbox' do
        before do
          visit new_user_path
          fill_in 'ユーザー名', with: 'Test_1'
          fill_in 'パスワード', with: 'password'
          fill_in 'パスワード（確認用）', with: 'password'
          # 同意しない
          # check '利用規約とプライバシーポリシーに同意する'

          click_button '確認画面へ'
        end
        it 'is failed' do
          expect(page).to have_content 'Term of serviceを受諾してください'
        end
      end

      context 'with duplicated name' do
        let!(:duplicated_user) { create(:user, name: 'Test_1') }
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

      context 'with wrong password_confirmation' do
        before do
          visit new_user_path
          fill_in 'ユーザー名', with: 'Test_1'
          fill_in 'パスワード', with: 'password'
          # 違うパスワードを入力する
          fill_in 'パスワード（確認用）', with: 'Test_1'
          check '利用規約とプライバシーポリシーに同意する'

          click_button '確認画面へ'
        end
        it 'is failed' do
          expect(page).to have_content 'Password confirmationとPasswordの入力が一致しません'
        end
      end
    end
  end

  describe 'destroy' do
    let!(:user){ create(:user) }
    let!(:child){ create(:child, user: user) }
    fcontext 'after login' do
      before do 
        login(user)
        page.accept_confirm do
          click_on '退会'
        end
      end
      it 'is successful' do
        expect(page).to have_content '退会が完了しました。ご利用ありがとうございました。'
        expect(current_path).to eq root_path
      end
    end
  end
end
