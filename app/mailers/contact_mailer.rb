class ContactMailer < ApplicationMailer
  def contact_mail(contact, user)
    @contact = contact
    @user = user
    mail to: contact.email, bcc: ENV["ACTION_MAILER_USER"], subject: 'お問い合わせ受付のお知らせ【kokeibo】'
  end
end
