class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def notice_on_published_post(user_email, post_title)
    @user_email = user_email
    @post_title = post_title
    @url  = 'http://example.com/login'
    mail(to: @user_email, subject: 'Welcome to My Awesome Site')
  end
end
