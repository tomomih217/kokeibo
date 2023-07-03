require 'rails_helper'

RSpec.describe "Simulations", type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  describe 'Result' do
    context 'with all attributes' do
      before do
        login(user)
        click_on '積立計画'
        click_on '教育費シュミレーション'
      end
      it 'is successful' do
        # テスト中
        expect(current_path).to eq new_simulation_path
      end
    end
  end 
end
