require 'rails_helper'

RSpec.describe "Payments", type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  before { login(user) }
  describe 'index' do
  end

  describe 'create' do
    let(:payment_collection){ build(:payment_collection, child: child) }
    let(:payment_1){ build(:payment, payment_collection: payment_collection) }
    let(:payment_2){ build(:payment, payment_collection: payment_collection) }
    let(:payment_3){ build(:payment, payment_collection: payment_collection) }
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
        # fill_in 'payment_collection[payments_attributes][0][item]', with: payment_1.item
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
        # fill_in 'payment_collection[payments_attributes][0][amount]', with: payment_1.amount
        click_on '登録する'
      end
      it 'is failed' do
        expect(page).to have_content '入金に失敗しました'
      end
    end
  end

  describe 'update' do
  end

  describe 'destroy' do
  end
end
