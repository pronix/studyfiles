# -*- coding: utf-8 -*-
module ApplicationHelper
  def guest_read_news?(id)
    return false unless session[:read_news].present?
    session[:read_news].include?(id)
  end
  
  def show_notify(id)
    true if current_user && !current_user.read_notify?(id)
  end
  def link_close_notify(id)
    link_to '', read_notification_path(:notification_type => 'notify',
                                       :notification_id => id),
                                       :class => "close icon",
                                       :title => "закрыть нотификацию #{id}",
                                       :remote => true, :method => :put
  end
end
