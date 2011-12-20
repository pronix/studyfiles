# -*- coding: utf-8 -*-
class Inboxes::DiscussionsController < Inboxes::BaseController
  before_filter :load_and_check_discussion_recipient, :only => :new

  def index
    @discussion = current_user.discussions.last_one
    if @discussion.present?
      @messages = @discussion.messages
      @discussion.mark_as_read_for(current_user)
    end
  end

  def show
    # @discussion = Discussion.includes(:messages, :speakers).find(params[:id])
    @discussion.mark_as_read_for(current_user)
  end

  def new
    @recipient = User.find(params[:id])
  end

  def create
    @discussion = Discussion.where(:id => params[:discussion_id]).first
    if @discussion
      Message.create(params[:message].merge({:discussion => @discussion,
                                              :user => current_user}))
    else
      @discussion = Discussion.new
      @discussion.recipient_ids = [current_user.id, params[:recipient_id]]
      @discussion.save
      Message.create(params[:message].merge({:discussion => @discussion,
                                              :user => current_user}))
    end
    redirect_to discussion_messages_path(@discussion),
    :notice => 'Сообщение отправленно'
  end

  private

  # def init_and_check_permissions
  #   @discussion = Discussion.includes(:messages, :speakers).find(params[:id])
  #   redirect_to discussions_url, :notice => t("inboxes.discussions.can_not_participate") unless @discussion.can_participate?(current_user)
  # end

  def load_and_check_discussion_recipient
    # initializing model for new and create actions
    @discussion = Discussion.new(params[:discussion].presence || {})
    # @discussion.recipient_tokens = params[:recipients] if params[:recipients] # pre-population

    # checking if discussion with this user already exists
    if @discussion.recipient_ids && @discussion.recipient_ids.size == 1
      user = User.find(@discussion.recipient_ids.first)
      discussion = Discussion.find_between_users(current_user, user)
      if discussion
        # it exists, let's add message and redirect current user
        @discussion.messages.each do |message|
          Message.create(:discussion => discussion, :user => current_user, :body => message.body) if message.body
        end
        # перекидываем на нее
        redirect_to discussion_url(discussion), :notice => t("inboxes.discussions.exists", :user => user[Inboxes::config.user_name])
      end
    end
  end
end
