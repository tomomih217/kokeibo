require 'rails_helper'

RSpec.describe 'Plans', type: :system do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, user: user) }
  describe 'index' do
    context 'access' do
      before do
        login(user)
        visit child_plans_path(child.id)
      end
      it 'is successful' do
        expect(page).to have_content '積立情報設定一覧'
        expect(page).to have_content child.result.cost_per_month.to_s(:delimited)
      end
    end
    context 'with registered plan' do
      let!(:plan) { create(:plan, child: child) }
      before do
        login(user)
        visit child_plans_path(child.id)
      end
      it 'can be displayed' do
        expect(page).to have_content '積立情報設定一覧'
        expect(page).to have_content plan.item
        expect(page).to have_content plan.amount.to_s(:delimited)
      end
    end
  end

  describe 'new' do
    before do
      login(user)
      visit new_child_plan_path(child.id)
    end
    context 'form' do
      # ここにtext_fieldのセレクタと期待するplaceholderの内容を設定してください
      item_text_field_selector = 'input[type="text" id="plan_form[plans_attributes][0][item]"]'
      item_expected_placeholder = '例)保険'

      amount_text_field_selector = 'input[type="text" id="plan_form[plans_attributes][0][amount]"]'
      amount_expected_placeholder = '例)15000'

      it 'can be displayed placeholder' do
        expect(page).to have_selector(item_text_field_selector, placeholder: item_expected_placeholder)
        expect(page).to have_selector(amount_text_field_selector, placeholder: amount_expected_placeholder)
      end
    end
  end

  describe 'create' do
    let(:plan) { build(:plan, child: child) }
    let(:plan_1) { build(:plan, child: child) }
    let(:plan_2) { build(:plan, child: child) }
    before do
      login(user)
      visit new_child_plan_path(child.id)
    end
    context 'with all attributes' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        # check 'plan_form_plans_attributes_0_is_auto'

        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '積立情報設定しました'
        expect(current_path).to eq child_plans_path(child.id)
      end
    end
    context 'without item' do
      before do
        # 費目を入力しない
        # fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        # check 'plan_form_plans_attributes_0_is_auto'

        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入力項目を確認してください'
        expect(page).to have_content '積立情報設定登録'
      end
    end
    context 'without amount' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        # 金額を入力しない
        # fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        # check 'plan_form_plans_attributes_0_is_auto'

        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入力項目を確認してください'
        expect(page).to have_content '積立情報設定登録'
      end
    end
    context 'without checking auto payment status' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        # 自動入金をチェックしない
        # check 'plan_form_plans_attributes_0_is_auto'

        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '積立情報設定しました'
        expect(current_path).to eq child_plans_path(child.id)
      end
    end
    context 'with other plans' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        # check 'plan_form_plans_attributes_0_is_auto'

        fill_in 'plan_form[plans_attributes][1][item]', with: plan_1.item
        fill_in 'plan_form[plans_attributes][1][amount]', with: plan_1.amount
        select plan_1.payment_day, from: 'plan_form[plans_attributes][1][payment_day]'
        check 'plan_form_plans_attributes_1_is_auto'

        fill_in 'plan_form[plans_attributes][2][item]', with: plan_2.item
        fill_in 'plan_form[plans_attributes][2][amount]', with: plan_2.amount
        select plan_2.payment_day, from: 'plan_form[plans_attributes][2][payment_day]'
        check 'plan_form_plans_attributes_2_is_auto'

        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '積立情報設定しました'
        expect(current_path).to eq child_plans_path(child.id)
      end
    end
    context 'with other lacking plan' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        check 'plan_form_plans_attributes_0_is_auto'

        # 費目を入力しない
        # fill_in 'plan_form[plans_attributes][1][item]', with: plan_1.item
        fill_in 'plan_form[plans_attributes][1][amount]', with: plan_1.amount
        select plan_1.payment_day, from: 'plan_form[plans_attributes][1][payment_day]'
        # check 'plan_form_plans_attributes_1_is_auto'

        fill_in 'plan_form[plans_attributes][2][item]', with: plan_2.item
        fill_in 'plan_form[plans_attributes][2][amount]', with: plan_2.amount
        select plan_2.payment_day, from: 'plan_form[plans_attributes][2][payment_day]'
        # check 'plan_form_plans_attributes_2_is_auto'

        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入力項目を確認してください'
        expect(page).to have_content '積立情報設定登録'
      end
    end
  end

  describe 'update' do
    let!(:plan) { create(:plan, child: child) }
    let(:add_plan) { build(:plan, child: child) }
    before do
      login(user)
      visit child_plans_edit_path(child.id)
    end
    context 'with all attributes of new plan' do
      before do
        fill_in 'plan_form[plans_attributes][1][item]', with: add_plan.item
        fill_in 'plan_form[plans_attributes][1][amount]', with: add_plan.amount
        select add_plan.payment_day, from: 'plan_form[plans_attributes][1][payment_day]'
        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '積立情報設定を編集しました'
        expect(current_path).to eq child_plans_path(child.id)
        expect(page).to have_content plan.item
        expect(page).to have_content add_plan.item
      end
    end
    context 'with other attribute of saved plan' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: add_plan.item
        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '積立情報設定を編集しました'
        expect(page).to have_content add_plan.item
        expect(page).to have_no_content plan.item
        expect(page).to have_content plan.amount.to_s(:delimited)
      end
    end
    context 'without plans' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: ''
        fill_in 'plan_form[plans_attributes][0][amount]', with: ''
        select '', from: 'plan_form[plans_attributes][0][payment_day]'
        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入力項目を確認してください'
      end
    end
  end

  describe 'destroy' do
    let!(:plan) { create(:plan, child: child) }
    before { login(user) }
    context 'a plan' do
      let!(:delete_plan) { create(:plan, child: child) }
      before do
        visit child_plans_path(child.id)
        find("#delete_button_for_plan_#{delete_plan.id}").click
      end
      it 'is successful' do
        expect(page).to have_content '積立情報設定を削除しました'
        expect(page).to have_no_content delete_plan.item
      end
    end
    context 'last plan' do
      before do
        visit child_plans_path(child.id)
        find("#delete_button_for_plan_#{plan.id}").click
      end
      it 'is successful' do
        expect(page).to have_content '積立情報設定を削除しました'
        expect(page).to have_no_content plan.item
        expect(page).to have_content '何もデータはありません'
      end
    end
  end
end
