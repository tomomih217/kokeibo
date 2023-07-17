require 'rails_helper'

RSpec.describe "Mypage", type: :system do
  describe 'dashboard' do
    let!(:user){ create(:user) }
    let!(:child){ create(:child, user: user) }
    context 'with child name' do
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_content child.name
      end
    end
    fcontext 'with plans' do
      let!(:plan_1){ create(:plan, child: child) }
      let!(:plan_2){ create(:plan, child: child) }
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_content plan_1.item
        expect(page).to have_content plan_1.amount.to_s(:delimited)
        expect(page).to have_content plan_2.item
        expect(page).to have_content plan_2.amount.to_s(:delimited)
        expect(page).to have_link '入 金', href: '#'
      end
    end
  end
end
