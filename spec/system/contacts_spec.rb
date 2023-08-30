require 'rails_helper'

RSpec.describe 'Contact', type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  describe 'create' do
    context 'access' do
      before do
        login(user)
        click_on 'お問い合わせ'
      end
      it 'is successful' do
        expect(current_path).to eq new_contact_path
      end
    end
  end
end