# -*- coding: utf-8 -*-
class FeedbackController < ApplicationController
  def new
    @feedback = Feedback.new
  end

  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.save
      FeedbackMailer.feedback_send(@feedback).deliver
      flash[:notice] = 'Ваше сообщение отправленно администрации'
      redirect_to root_path
    else
      render :new
    end
  end
end
