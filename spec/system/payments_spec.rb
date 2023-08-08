require 'rails_helper'

RSpec.describe 'Payments', type: :system do
  let!(:user) { create(:user) }
  let!(:child) { create(:child, user: user) }
  let!(:plan_1) { create(:plan, item: '保険', amount: 20_000, child: child) }
  let!(:plan_2) { create(:plan, item: '投資', amount: 10_000, child: child) }
  before { login(user) }
  describe 'index' do
    let!(:payment_collection) { create(:payment_collection, child: child) }
    let!(:payment_1) { create(:payment, :insurance, payment_collection: payment_collection) }
    let!(:payment_2) { create(:payment, :investment, payment_collection: payment_collection) }
    let!(:payment_3) { create(:payment, :savings, payment_collection: payment_collection) }
    context 'access' do
      before { click_on '履歴' }
      it 'is successful' do
        expect(current_path).to eq child_payment_collections_path(child.id)
      end
    end
    context 'with all payments' do
      before { visit child_payment_collections_path(child.id) }
      it 'can be displayed' do
        expect(page).to have_content '入金履歴'
        expect(page).to have_content payment_collection.decorate.format_paymented_at
        expect(page).to have_content payment_1.item
        expect(page).to have_content payment_2.item
        expect(page).to have_content payment_3.item
      end
    end
    context 'with payments for another child' do
      let!(:another_child) { create(:child, user: user) }
      let!(:payment_collection_for_another_child) { create(:payment_collection, child: another_child) }
      let!(:payment_4) do
        create(:payment, item: '株', amount: 40_000, payment_collection: payment_collection_for_another_child)
      end
      before { visit child_payment_collections_path(child.id) }
      it 'cannot be displayed' do
        expect(page).to have_content '入金履歴'
        expect(page).to have_no_content payment_4.item
        expect(page).to have_no_content payment_4.amount
      end
    end
  end

  describe 'create' do
    let(:payment_collection) { build(:payment_collection, child: child) }
    let(:payment_1) { build(:payment, :insurance, payment_collection: payment_collection) }
    let(:payment_2) { build(:payment, :investment, payment_collection: payment_collection) }
    let(:payment_3) { build(:payment, :savings, payment_collection: payment_collection) }
    before { click_on '入 金' }
    context 'access' do
      it 'is successful' do
        expect(current_path).to eq new_child_payment_collection_path(child.id)
      end
    end
    context 'with all attributes' do
      before do
        fill_in 'payment_collection[paymented_at]', with: Date.today

        fill_in 'payment_collection[payments_attributes][0][item]', with: payment_1.item
        fill_in 'payment_collection[payments_attributes][0][amount]', with: payment_1.amount

        fill_in 'payment_collection[payments_attributes][1][item]', with: payment_2.item
        fill_in 'payment_collection[payments_attributes][1][amount]', with: payment_2.amount

        fill_in 'payment_collection[payments_attributes][2][item]', with: payment_3.item
        fill_in 'payment_collection[payments_attributes][2][amount]', with: payment_3.amount

        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '入金しました'
      end
    end
    context 'with only 1 payment attributes' do
      before do
        fill_in 'payment_collection[paymented_at]', with: Date.today

        fill_in 'payment_collection[payments_attributes][0][item]', with: payment_1.item
        fill_in 'payment_collection[payments_attributes][0][amount]', with: payment_1.amount
        fill_in 'payment_collection[payments_attributes][1][item]', with: ''
        fill_in 'payment_collection[payments_attributes][1][amount]', with: ''
        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '入金しました'
      end
    end
    context 'without item' do
      before do
        fill_in 'payment_collection[paymented_at]', with: Date.today

        # 費目を入力しません
        fill_in 'payment_collection[payments_attributes][0][item]', with: ''
        fill_in 'payment_collection[payments_attributes][0][amount]', with: payment_1.amount
        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入金に失敗しました'
      end
    end
    context 'without amount' do
      before do
        fill_in 'payment_collection[paymented_at]', with: Date.today

        fill_in 'payment_collection[payments_attributes][0][item]', with: payment_1.item
        # 金額を入力しない
        fill_in 'payment_collection[payments_attributes][0][amount]', with: ''
        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入金に失敗しました'
      end
    end
    context 'form with registered plans' do
      before do
        fill_in 'payment_collection[paymented_at]', with: Date.today
      end
      it 'can be displayed' do
        expect(page).to have_field 'payment_collection[payments_attributes][0][item]', with: plan_1.item
        expect(page).to have_field 'payment_collection[payments_attributes][0][amount]', with: plan_1.amount
        expect(page).to have_field 'payment_collection[payments_attributes][1][item]', with: plan_2.item
        expect(page).to have_field 'payment_collection[payments_attributes][1][amount]', with: plan_2.amount
        expect(page).to have_field 'payment_collection[payments_attributes][2][item]', with: ''
        expect(page).to have_field 'payment_collection[payments_attributes][2][amount]', with: ''
      end
    end
  end

  describe 'update' do
    let!(:payment_collection) { create(:payment_collection, child: child) }
    let!(:payment_1) { create(:payment, :insurance, payment_collection: payment_collection) }
    let!(:payment_2) { create(:payment, :investment, payment_collection: payment_collection) }
    let!(:payment_3) { create(:payment, :savings, payment_collection: payment_collection) }
    before do
      visit child_payment_collections_path(child.id)
      click_on '編集'
    end
    context 'access' do
      it 'is successful' do
        expect(current_path).to eq edit_payment_collection_path(payment_collection.id)
      end
    end
    context 'to change paymented_at' do
      before do
        visit edit_payment_collection_path(payment_collection.id)
        fill_in 'payment_collection[paymented_at]', with: payment_collection.paymented_at.tomorrow
        click_on '登録する'
      end
      it 'is successful' do
        changed_paymented_at = payment_collection.paymented_at.tomorrow
        expect(page).to have_content '入金情報を編集しました'
        expect(page).to have_no_content payment_collection.decorate.format_paymented_at
        expect(page).to have_content "#{changed_paymented_at.year}年#{changed_paymented_at.month}月#{changed_paymented_at.day}日"
      end
    end
    context 'to change 1 payment' do
      let(:changed_payment) do
        build(:payment, item: 'つみたてNISA', amount: 20_000, payment_collection: payment_collection)
      end
      before do
        visit edit_payment_collection_path(payment_collection.id)
        fill_in 'payment_collection[payments_attributes][0][item]', with: changed_payment.item
        fill_in 'payment_collection[payments_attributes][0][amount]', with: changed_payment.amount
        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '入金情報を編集しました'
        expect(page).to have_content changed_payment.item
        expect(page).to have_content "¥#{changed_payment.amount.to_s(:delimited)}"
      end
    end
    context 'to delete 1 payment' do
      before do
        visit edit_payment_collection_path(payment_collection.id)
        check 'payment_collection[payments_attributes][2][_destroy]'
        click_on '登録する'
      end
      it 'is successful' do
        expect(page).to have_content '入金情報を編集しました'
        expect(page).to have_content payment_1.item
        expect(page).to have_content "¥#{payment_1.amount.to_s(:delimited)}"
        expect(page).to have_content payment_2.item
        expect(page).to have_content "¥#{payment_2.amount.to_s(:delimited)}"
        expect(page).to have_no_content payment_3.item
        expect(page).to have_no_content "¥#{payment_3.amount.to_s(:delimited)}"
      end
    end
    context 'without only item' do
      before do
        visit edit_payment_collection_path(payment_collection.id)
        fill_in 'payment_collection[payments_attributes][0][item]', with: ''
        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '編集に失敗しました'
      end
    end
    context 'without only amount' do
      before do
        visit edit_payment_collection_path(payment_collection.id)
        fill_in 'payment_collection[payments_attributes][0][amount]', with: ''
        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '編集に失敗しました'
      end
    end
  end

  describe 'destroy' do
    let!(:payment_collection) { create(:payment_collection, child: child) }
    let!(:payment_1) { create(:payment, :insurance, payment_collection: payment_collection) }
    let!(:payment_2) { create(:payment, :investment, payment_collection: payment_collection) }
    let!(:payment_3) { create(:payment, :savings, payment_collection: payment_collection) }
    before { visit child_payment_collections_path(child.id) }
    context 'by payment_collection' do
      before do
        page.accept_confirm do
          click_on '削除'
        end
      end
      it 'is successful' do
        expect(page).to have_content '入金情報を削除しました'
        expect(page).to have_no_content payment_1.item
        expect(page).to have_no_content payment_2.item
        expect(page).to have_no_content payment_3.item
        expect(page).to have_content 'データはありません'
      end
    end
  end
end
