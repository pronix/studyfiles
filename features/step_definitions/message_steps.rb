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

Допустим /^сообщения от пользователя "(.+)" написаны давно$/ do |user|
  Message.where(:user_id => User.find_by_email(user).id).update_all(:created_at => Time.now - 1.day,
                                                                    :updated_at => Time.now - 1.day)
end

Допустим /^последнее сообщение от пользователя "(.+)" содержит текст "(.+)"$/ do |user, message|
  Message.find_by_user_id(User.find_by_email(user)).update_attribute(:body, message)
end


Допустим /^пользователь "(.+)" должен иметь (\d+) не прочитанное сообщение$/ do |user, amount|
  User.find_by_email(user).unread_message_count.should == amount.to_i
end

Допустим /^последнее присланное пользователю "(.+)" содержит "(.+)"$/ do |user, message|
  User.find_by_email(user).unread_messages.last.body.should == message
end
