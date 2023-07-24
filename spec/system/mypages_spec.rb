require 'rails_helper'

RSpec.describe "Mypage", type: :system do
  describe 'in dashboard' do
    let!(:user){ create(:user) }
    let!(:child){ create(:child, user: user) }
    context 'with child name' do
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_content child.name
        expect(page).to have_content 'データはありません'
      end
    end
    context 'with plans' do
      let!(:plan_1){ create(:plan, child: child) }
      let!(:plan_2){ create(:plan, child: child) }
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_content plan_1.item
        expect(page).to have_content plan_1.amount.to_s(:delimited)
        expect(page).to have_content plan_2.item
        expect(page).to have_content plan_2.amount.to_s(:delimited)
        expect(page).to have_link '入 金', href: new_child_payment_collection_path(child.id)
      end
    end
    context 'pie chart for savings amount with payment' do
      let!(:payment_collection_1){ create(:payment_collection, child: child) }
      let!(:payment_collection_2){ create(:payment_collection, child: child) }
      let!(:payment_1){ create(:payment, :insurance, payment_collection: payment_collection_1) }
      let!(:payment_2){ create(:payment, :investment, payment_collection: payment_collection_2) }
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_selector '#savings_amount_pie_chart'
        expect(page).to have_content child.payments.sum(:amount).to_s(:delimited)
        expect(page).to have_content child.diff_amount.to_s(:delimited)
        expect(page).to have_content child.estimated_amount.to_s(:delimited)
      end
    end
    context 'with difference between cost and savings' do
      let!(:result){ create(:result, child: child) }
      let!(:plan_1){ create(:plan, child: child) }
      let!(:plan_2){ create(:plan, child: child) }
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_content '高校入学時'
        expect(page).to have_content child.result.each_stage_cost[:high_school_cost].to_s(:delimited)
        expect(page).to have_content child.culculated_amount(15).to_s(:delimited)
        expect(page).to have_content (child.result.each_stage_cost[:high_school_cost] - child.culculated_amount(15)).to_s(:delimited)
        expect(page).to have_content '大学入学時'
        expect(page).to have_content child.result.each_stage_cost[:university_cost].to_s(:delimited)
        expect(page).to have_content child.culculated_amount(18).to_s(:delimited)
        expect(page).to have_content (child.result.each_stage_cost[:university_cost] - child.culculated_amount(18)).to_s(:delimited)
      end
    end
  end
end
