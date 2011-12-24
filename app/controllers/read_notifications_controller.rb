class ReadNotificationsController < ApplicationController
  def update
    ReadNotification.create(:notification_type => params[:notification_type],
                            :notification_id => params[:notification_id],
                            :user_id => current_user.id)
    render :nothing => true
  end
end
