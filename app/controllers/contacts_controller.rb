class ContactsController < ApplicationController
  layout 'after_login_layout'
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.contact_mail(@contact, current_user).deliver
      redirect_to mypage_path, success: 'お問い合わせを送信しました。ありがとうございました。'
    else
      flash.now[:danger] = '送信に失敗しました。'
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :content).merge(user_id: current_user.id)
  end
end
