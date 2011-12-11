# -*- coding: utf-8 -*-
class UniversitiesController < ApplicationController

  before_filter :get_right_column

  #Главная страница
  def index
    @universities = University.search params[:search], :star => true
  end

  def new
    @university = University.new
  end

  def create
    @university = University.new(params[:university])
    if @university.save
        current_user.universities << @university
        flash[:notice] = "Добавлен университет"
    else
      flash[:alert] = "Не получилось добавить университет"
    end
    redirect_to user_path(current_user)
  end


  private

  #строим правый сайдбар с новостями и топ-10
  def get_right_column
    @news = Novelty.where(:main => true)
    @stats = {:universtites => University.count,
              :subjects     => Subject.count,
              :files        => Document.count,
              :file_size    => Document.sum(:item_file_size),
              :users        => User.count
    }
  end

end
