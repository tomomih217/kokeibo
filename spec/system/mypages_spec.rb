require 'rails_helper'

RSpec.describe 'Mypage', type: :system do
  describe 'in dashboard' do
    let!(:user) { create(:user) }
    let!(:child) { create(:child, user: user) }
    context 'with child name' do
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_content child.name
        expect(page).to have_content 'データはありません'
        expect(page).to have_link '積立情報設定の新規登録', href: new_child_plan_path(child)
        expect(page).to have_link '希望進路を登録する'
      end
    end
    context 'with plans' do
      let!(:plan_1) { create(:plan, child: child) }
      let!(:plan_2) { create(:plan, child: child) }
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_content plan_1.item
        expect(page).to have_content plan_1.amount.to_s(:delimited)
        expect(page).to have_content plan_2.item
        expect(page).to have_content plan_2.amount.to_s(:delimited)
        expect(page).to have_link '入 金', href: new_child_payment_collection_path(child.id)
        expect(page).to have_no_link '積立情報設定の新規登録'
      end
    end
    context 'pie chart for savings amount with payment' do
      let!(:payment_collection_1) { create(:payment_collection, child: child) }
      let!(:payment_collection_2) { create(:payment_collection, child: child) }
      let!(:payment_1) { create(:payment, :insurance, payment_collection: payment_collection_1) }
      let!(:payment_2) { create(:payment, :investment, payment_collection: payment_collection_2) }
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_selector '#savings_amount_pie_chart'
        expect(page).to have_content child.payments.sum(:amount).to_s(:delimited)
        expect(page).to have_content child.diff_amount.to_s(:delimited)
        expect(page).to have_content child.estimated_amount.to_s(:delimited)
      end
    end
    context 'with difference between cost and savings' do
      let!(:result) { create(:result, child: child) }
      let!(:plan_1) { create(:plan, child: child) }
      let!(:plan_2) { create(:plan, child: child) }
      before { login(user) }
      it 'can be displayed' do
        expect(page).to have_no_link '希望進路を登録する'
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
    context 'with payed amount in this month' do
      let!(:plan_1) { create(:plan, amount: 10_000, child: child) }
      let!(:plan_2) { create(:plan, amount: 20_000, child: child) }
      let!(:payment_collection_1) { create(:payment_collection, paymented_at: Date.today, child: child) }
      let!(:payment_1) do
        create(:payment, item: plan_1.item, amount: plan_1.amount, payment_collection: payment_collection_1)
      end
      let!(:payment_collection_2) { create(:payment_collection, paymented_at: Date.today + 1.month, child: child) }
      let!(:payment_2) do
        create(:payment, item: plan_2.item, amount: plan_2.amount, payment_collection: payment_collection_2)
      end
      before { login(user) }
      it 'can be displayed checkmark' do
        expect(page).to have_content plan_1.item
        expect(page).to have_content plan_1.amount.to_s(:delimited)
        expect(page).to have_selector "#check_for_#{plan_1.id}"
        expect(page).to have_no_selector "#check_for_#{plan_2.id}"
      end
    end
    fcontext 'with both plans and result' do
      let!(:result) { create(:result, child: child) }
      let!(:plan) { create(:plan, child: child) }
      before { login(user) }
      it 'can be displayed saving_plan_graph' do
        expect(page).to have_selector '#saving_plan_graph'
      end
    end
  end

  describe 'Change child' do
    let!(:user) { create(:user) }
    let!(:child) { create(:child, user: user) }
    fcontext 'clicked arrow button' do
      let!(:another_child){ create(:child, name: 'another', user: user) }
      before do
        login(user)
        find('next_child').click
      end
      it 'is successful' do
        expect(page).to have_content "#{another_child.name}ちゃん"
      end
    end
    fcontext 'selected another child' do
      let!(:another_child){ create(:child, name: 'another', user: user) }
      before do
        login(user)
        find("child_#{another_child.id}").click
      end
      it 'is successful' do
        it 'is successful' do
          expect(page).to have_content "#{another_child.name}ちゃん"
        end
      end
    end
    fcontext 'without another child' do
      before { login(user) }
      it 'cannot be displayed arrow button' do
        expect(page).to have_no_selector '#next_child'
        expect(page).to have_no_selector '#previous_child'
      end
    end
  end

  describe 'tutorial' do
    let!(:user) { create(:user) }
    let!(:child) { create(:child, user: user) }
    fcontext 'without result and plans' do
      before { login(user) }
      it 'starts successful' do
        expect(page).to have_content '希望進路を登録してください'
        expect(page).to have_content '希望進路登録'
        expect(current_path).to eq new_child_simulation_path(child)
      end
    end
    fcontext 'with result' do
      let!(:result) { create(:result, child: child) }
      before { login(user) }
      it 'does not start' do
        expect(current_path).to eq mypage_path(child)
      end
    end
    fcontext 'with plans' do
      let!(:payment_collection) { create(:payment_collection, child: child) }
      let!(:plan) { create(:plan, payment_collection: payment_collection) }
      it 'does not start' do
        expect(current_path).to eq mypage_path(child)
      end
    end
    fcontext 'after cancel' do
      before do
        login(user)
        click_button '後で'
      end
      it 'can be display mypage' do
        expect(current_path).to eq mypage_path(child)
      end
    end
  end
end
