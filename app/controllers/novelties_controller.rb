# -*- coding: utf-8 -*-
class NoveltiesController < ApplicationController
  before_filter :authorize, :only => [:new, :create, :edit, :update]

  def index
    @news = Novelty.all
  end

  def new
    @novelty = Novelty.new
  end

  def edit
    @novelty = Novelty.find(params[:id])
  end

  def update
    @novelty = Novelty.find(params[:id])
    if @novelty.update_attributes(params[:novelty])
      redirect_to novelties_path
    else
      render :edit
    end
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
