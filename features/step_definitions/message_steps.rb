# -*- coding: utf-8 -*-
Допустим /^пользователю "(.+)" написали (\d+) сообщения$/ do |user, amount|
  user = User.find_by_email(user)
  send_user = Factory(:user)
  discussion = Discussion.create(:recipient_tokens => [user.id, send_user.id])
  1.upto(amount.to_i).each do |i|
    Message.create(:discussion => discussion, :user => send_user, :body => 'dsadsdsdasds')
  end
end


Допустим /^пользователь "(.+)" написал пользователю "(.+)"$/ do |sender, recipient|
  sender = User.find_by_email(sender)
  recipient = User.find_by_email(recipient)
  dis = Discussion.create(:recipient_tokens => [sender.id, recipient.id])
  Message.create(:discussion => dis, :user => sender, :body => "dasdsadas")
end

Допустим /^пользователь "(.+)" написал пользователю "(.+)" (\d+) сообщение$/ do |sender, recipient, amount|
  sender = User.find_by_email(sender)
  recipient = User.find_by_email(recipient)
  dis = Discussion.create(:recipient_tokens => [sender.id, recipient.id])
  1.upto(amount.to_i).each { Message.create(:discussion => dis, :user => sender, :body => "dasdsadas") }
end
