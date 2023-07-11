require 'rails_helper'

RSpec.describe "Plans", type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  describe 'index' do
    context 'access' do
      before do
        login(user)
        click_on '入金設定'
      end
      it 'is successful' do
        expect(current_path).to eq plans_path
        expect(page).to have_content '入金設定一覧'
      end
    end
    xcontext 'with registered plan' do
      it 'can be displayed' do
      end
    end
  end

  describe 'create' do
    xcontext 'with all attributes' do
      it 'is successful' do
      end
    end
    xcontext 'without item' do
      it 'is failed' do
      end
    end
    xcontext 'without amount' do
      it 'is failed' do
      end
    end
    xcontext 'with checking auto payment status' do
      it 'is successful' do
      end
    end
    xcontext 'with other plans' do
      it 'is successful' do
      end
    end
    xcontext 'with other lacking plan' do
      it 'is failed' do
      end
    end
  end
end
