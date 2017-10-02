class SendEmailMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.send_email_mailer.welcome.subject
  #
  def welcome(user)
      @name = user.name
      attachments[user.image.photo_file_name] = user.image.photo.path
      mail(to: user.email , subject: "welcome!, Enjoy free shopping")
  end
end
