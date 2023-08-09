require 'rails_helper'

RSpec.describe 'FlashMessage', type: :system do
  let!(:user) { create(:user) }
  let(:wrong_user){ build(:user, password: '') }
  describe 'of success type' do
    before { login(user) }
    context 'is green' do
      expect(find('#flash_message')).to have_css '.bg-success-100'
    end
  end
  describe 'of danger type' do
    before { login(wrong_user) }
    context 'is red' do
      expect(find('#flash_message')).to have_css '.bg-danger-100'
    end
  end
end