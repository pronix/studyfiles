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
  Message.where("user_id != ?", User.find_by_email(user)).last.body.should == message
  
end


Допустим /^я не должен видеть "(.+)" в собеседниках$/ do |text|
  find_by_id('contacts-list').should have_no_content(text)
end

Допустим /^пользователь "(.+)" просто имеет со мной дискуссию$/ do |ext_user|
  Discussion.create(:recipient_tokens => [User.find_by_email('user@example.com').id,
                                          User.find_by_email(ext_user).id])
end

Допустим /^пользователь "(.+)" давно не заходил на страницу$/ do |user|
  User.find_by_email(user).speakers.last.update_attribute(:updated_at, Time.now - 1.day)
end

Допустим /^все сообщения пришли только что$/ do
  Message.update_all(:updated_at => Time.now)
end
