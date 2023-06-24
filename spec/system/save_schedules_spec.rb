require 'rails_helper'

RSpec.describe "SaveSchedules", type: :system do
  let!(:user){ create(:user) }
  describe 'Create' do
    describe 'batch' do
      fcontext 'with all attributes' do
        before do
          login(user)
          click_on '積立計画'
        end
        it 'is successfull' do
          expect(page).to have_content '積立計画登録画面'
        end
      end
      context 'without term' do
        it 'is failed' do
        end
      end
      context 'without amount' do
        it 'is failed' do
        end
      end
    end
  end
end
