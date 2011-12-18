# -*- coding: utf-8 -*-
Допустим /^пользователю "(.+)" написали (\d+) сообщения$/ do |user, amount|
  user = User.find_by_email(user)
  send_user = Factory(:user)
  discussion = Discussion.create(:recipient_tokens => [user.id, send_user.id])
  1.upto(amount.to_i).each do |i|
    Message.create(:discussion => discussion, :user => send_user, :body => 'dsadsdsdasds')
  end
  # puts Message.all.inspect

  # puts Speaker.all
  # puts Discussion.all
  # Speaker.update_all(:updated_at => Time.now - 1.day)
  puts "unread"
  pp user.discussions.last.unread_messages_count_for(user)
  # puts user.discussions.each {|d| d.unread_messages_count_for(user) }
  # puts Discussion.unread_messages_count_for(user)

end
