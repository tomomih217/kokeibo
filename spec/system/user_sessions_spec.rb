require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  describe 'Login' do
    let!(:user){ create(:user) }
    context 'form' do
      before do 
        visit login_path
      end
      it 'is currect' do
        expect(current_path).to eq login_path # ログイン画面への遷移が正常に行われていること

        expect(page).to have_selector('label', text: 'ユーザー名') # ユーザー名のラベルが表示されていることを確認
        expect(page).to have_field 'user[name]' # name属性が'user[name]'であるinputフィールドが表示されていることを確認

        expect(page).to have_selector('label', text: 'パスワード') # パスワードのラベルが表示されていることを確認
        expect(page).to have_field 'user[password]' # name属性が'user[password]'であるinputフィールドが表示されていることを確認

        expect(page).to have_selector('label', text: 'ログイン情報を保持する') # ログイン情報を保持するかどうかのラベルが表示されていることを確認
        expect(page).to have_field 'user[remember]' # name属性が'user[remember]'であるcheckboxが表示されていることを確認

        expect(page).to have_button 'ログイン' # ログインボタンが表示されているか確認
      end
    end

    context 'with all attributes' do
      before do
        visit login_path

        fill_in 'ユーザー名', with: user.name
        fill_in 'パスワード', with: 'password'
        check 'ログイン情報を保持する'
        click_button 'ログイン'
      end
      it 'is successful' do
        expect(current_path).to eq mypage_path # マイページに遷移されていること
        expect(page).to have_content "#{user.name}さんのマイページです" # ログインしたユーザーのマイページが表示されていること
        expect(page).to have_content "こんにちは、#{user.name}さん" # フラッシュメッセージが表示されていること
      end
    end
  end
end
