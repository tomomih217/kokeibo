require 'rails_helper'

RSpec.describe "Plans", type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  describe 'index' do
    context 'access' do
      before do
        login(user)
        visit child_plans_path(child.id)
      end
      it 'is successful' do
        expect(page).to have_content '入金設定一覧'
      end
    end
    context 'with registered plan' do
      let!(:plan){ create(:plan, child: child) }
      before do
        login(user)
        visit child_plans_path(child.id)
      end
      it 'can be displayed' do
        expect(page).to have_content '入金設定一覧'
        expect(page).to have_content plan.item
        expect(page).to have_content plan.amount
      end
    end
  end

  describe 'create' do
    let(:plan){ build(:plan, child: child) }
    let(:plan_1){ build(:plan, child: child) }
    let(:plan_2){ build(:plan, child: child) }
    before do
      login(user)
      visit new_child_plan_path(child.id)
    end
    context 'with all attributes' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        check 'plan_form_plans_attributes_0_is_auto'

        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '入金設定しました'
        expect(current_path).to eq child_plans_path(child.id)
      end
    end
    context 'without item' do
      before do
        # 費目を入力しない
        # fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        check 'plan_form_plans_attributes_0_is_auto'

        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入力項目を確認してください'
        expect(page).to have_content '入金設定登録'
      end
    end
    context 'without amount' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        # 金額を入力しない
        # fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        check 'plan_form_plans_attributes_0_is_auto'

        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入力項目を確認してください'
        expect(page).to have_content '入金設定登録'
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
        expect(page).to have_content '入金設定しました'
        expect(current_path).to eq child_plans_path(child.id)
      end
    end
    context 'with other plans' do
      before do
        fill_in 'plan_form[plans_attributes][0][item]', with: plan.item
        fill_in 'plan_form[plans_attributes][0][amount]', with: plan.amount
        select plan.payment_day, from: 'plan_form[plans_attributes][0][payment_day]'
        check 'plan_form_plans_attributes_0_is_auto'

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
        expect(page).to have_content '入金設定しました'
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
        check 'plan_form_plans_attributes_1_is_auto'

        fill_in 'plan_form[plans_attributes][2][item]', with: plan_2.item
        fill_in 'plan_form[plans_attributes][2][amount]', with: plan_2.amount
        select plan_2.payment_day, from: 'plan_form[plans_attributes][2][payment_day]'
        check 'plan_form_plans_attributes_2_is_auto'

        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入力項目を確認してください'
        expect(page).to have_content '入金設定登録'
      end
    end
  end

  describe 'update' do
    xcontext 'with all attributes' do
      it 'is successful' do
        
      end
    end
    xcontext 'with deleting saved plan' do
      it 'is successful' do
      end
    end
    xcontent 'without saved plans' do
      it 'is failed' do
      end
    end
  end

  describe 'delete' do
    xcontext 'a plan' do
      it 'is successful' do
      end
    end
    xcontext 'last plan' do
      it 'is successful' do
      end
    end
  end
end
