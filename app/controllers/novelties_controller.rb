# -*- coding: utf-8 -*-
class NoveltiesController < ApplicationController
  before_filter :authorize, :only => [:new, :create, :edit, :update]

  def index
    @news = Novelty.order('created_at DESC').
      paginate(:page => params[:page], :per_page => 5)
  end

  def new
    @novelty = Novelty.new
  end

  def edit
    @novelty = Novelty.find(params[:id])
  end

  def update
    @novelty = Novelty.find(params[:id])
    @novelty.update_attributes(params[:novelty])
    redirect_to novelties_path
  end

  def create
    @novelty = Novelty.new(params[:novelty])
    if @novelty.save
      redirect_to novelties_path
    else
      render :new
    end
  end

  private

  def authorize
    authorize! :manage, Novelty
  end

end
