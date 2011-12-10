# -*- coding: utf-8 -*-
# OPTIMIZE: default email to config!
class FeedbackMailer < ActionMailer::Base
  default from: 'site@example.com'

  def feedback_send(feedback)
    @feedback = feedback
    mail(:to => Setting.admin_email, :subject => "Новый отзыв с адреса #{@feedback.email}")
  end
end
