class ReadNotificationsController < ApplicationController
  def update
    if current_user
      ReadNotification.create(:notification_type => params[:notification_type],
                              :notification_id => params[:notification_id],
                              :user_id => current_user.id)
    else
      session[:read_news] = [] unless session[:read_news].present?
      session[:read_news] << params[:notification_id].to_i
    end
    render :nothing => true
  end
end
