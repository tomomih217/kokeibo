require 'rails_helper'

RSpec.describe 'Children', type: :system do
  let!(:user) { create(:user) }
  describe 'create' do
    let(:child) { build(:child, user: user) }
    context 'with all atttributes' do
      before do
        login(user)
        click_on 'お子様の情報を登録'

        fill_in 'お子様の名前', with: child.name
        select '出産前', from: 'ステージ'
        click_button '登録する'
      end
      it 'is successful' do
        expect(current_path).to eq mypage_path
        expect(page).to have_content 'お子様の情報を新規登録しました'
      end
    end
    context 'without name' do
      before do
        login(user)
        click_on 'お子様の情報を登録'

        # 名前を入力しない
        # fill_in 'お子様の名前', with: child.name
        select '出産前', from: 'ステージ'
        click_button '登録する'
      end
      it 'is failed' do
        expect(page).to have_content 'お子様の名前を入力してください'
      end
    end
    context 'without age' do
      before do
        login(user)
        click_on 'お子様の情報を登録'

        fill_in 'お子様の名前', with: child.name
        # ステージを選択しない
        # select '出産前', from: 'ステージ'
        click_button '登録する'
      end
      it 'is failed' do
        expect(page).to have_content 'ステージを入力してください'
      end
    end
  end
end
