class Inboxes::MessagesController < Inboxes::BaseController
  # before_filter :init_discussion
  # load_and_authorize_resource
  # load_and_authorize_resource :discussion
  load_resource :message, :through => :discussion, :shallow => true

  def index
    @discussion = Discussion.find(params[:discussion_id])
    @messages = Message.order('id DESC').where(:discussion_id => @discussion.id)
    render 'inboxes/discussions/index'
  end

  def create
    @discussion = Discussion.find(params[:discussion_id])
    @message = Message.new(params[:message])
    @message.update_attributes(:user => current_user, :discussion => @discussion)

    respond_to do |format|
      format.html { redirect_to discussions_path }
      format.js
    end
  end

  # private
  #
  # def init_and_check_permissions
  #   @discussion = Discussion.find(params[:discussion_id])
  #   redirect_to discussions_url, :notice => t("inboxes.discussions.can_not_participate") unless @discussion.can_participate?(current_user)
  # end
end
