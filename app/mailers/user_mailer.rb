# app/mailers/user_mailer.rb
class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail(to: @user[:email_address], subject: 'Welcome to My App', body: 'Dear '+@user[:full_name]+',This is to notify you that your registration is received and is undergoing review. Thank you!')
  end
  def approved_email(user)
    @user = user
    mail(to: @user[:email_address], subject: 'Approved Account', body: 'Dear '+@user[:full_name]+',This is to notify you that your registration has been approved.You may now login to your account and start stock trading. Thank you!')
  end
end
