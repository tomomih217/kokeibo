require 'rails_helper'

RSpec.describe "Children", type: :system do
  let!(:user){ create(:user) }
  describe 'create' do
    let(:child){ build(:child) }
    before do
      login(user)
      click_on 'お子様の情報を登録'

      fill_in 'お子様の名前', with: child.name
      fill_in 'ステージ', with: child.stage
      click_button '登録'
    end
    fcontext 'with all atttributes' do
      it 'is successful' do
        fail
      end
    end
    context 'without name' do
      it 'is failed' do
      end
    end
    context 'without age' do
      it 'is failed' do
      end
    end
  end
end
