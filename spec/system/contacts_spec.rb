require 'rails_helper'

RSpec.describe 'Contact', type: :system do
  let!(:user){ create(:user) }
  let!(:child){ create(:child, user: user) }
  describe 'create' do
    let(:contact){ build(:contact, user: user) }
    before do
      login(user)
      click_on 'お問い合わせ'
    end
    context 'access' do
      it 'is successful' do
        expect(current_path).to eq new_contact_path
      end
    end
    context 'with all attributes' do
      before do
        fill_in 'メールアドレス', with: contact.email
        fill_in 'お問い合わせ内容', with: contact.content

        click_button '送信'
      end
      it 'is successful' do
        expect(page).to have_content 'お問い合わせを送信しました。ありがとうございました。'
        expect(current_path).to eq mypage_path
      end
    end
    context 'without email' do
      before do
        # fill_in 'メールアドレス', with: contact.email
        fill_in 'お問い合わせ内容', with: contact.content

        click_button '送信'
      end
      it 'is failed' do
        expect(page).to have_content '送信に失敗しました。'
        expect(page).to have_content 'メールアドレスを入力してください'
      end
    end
    context 'without content' do
      before do
        fill_in 'メールアドレス', with: contact.email
        # fill_in 'お問い合わせ内容', with: contact.content

        click_button '送信'
      end
      it 'is failed' do
        expect(page).to have_content '送信に失敗しました。'
        expect(page).to have_content 'お問い合わせ内容を入力してください'
      end
    end
  end
end