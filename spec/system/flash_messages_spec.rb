require 'rails_helper'

RSpec.describe 'FlashMessage', type: :system do
  let!(:user) { create(:user) }
  let!(:child){ create(:child, user: user) }
  let(:wrong_user){ build(:user, name: '') }
  context 'of success type' do
    before { login(user) }
    it 'is green' do  
      expect(page).to have_css '.bg-success-100'
      expect(page).to have_css '.border-success-500'
      expect(page).to have_css '.text-success-700'
    end
  end
  context 'of danger type' do
    before { login(wrong_user) }
    it 'is red' do
      expect(page).to have_css '.bg-danger-100'
      expect(page).to have_css '.border-danger-500'
      expect(page).to have_css '.text-danger-700'
    end
  end
end