# -*- coding: utf-8 -*-
Допустим /^пользователю "(.+)" написали (\d+) сообщения$/ do |user, amount|
  user = User.find_by_email(user)
  send_user = Factory(:user)
  discussion = Discussion.create(:recipient_tokens => [user.id, send_user.id])
  1.upto(amount.to_i).each do |i|
    Message.create(:discussion => discussion, :user => send_user, :body => 'dsadsdsdasds')
  end
end
