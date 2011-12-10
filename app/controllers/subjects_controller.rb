# -*- coding: utf-8 -*-
class SubjectsController < ApplicationController

  def index
    @university = University.find(params[:university_id])
    @subjects = Subject.search params[:search]
  end

  def new
    @university = University.find(params[:university_id])
    @subject = @university.subjects.new
  end

  def create
    @university = University.find(params[:university_id])
    @subject = Subject.new(params[:subject])
    if @subject.save
      @university.subjects << @subject
      flash[:notice] = "Добавлен предмет"
    else
      flash[:alert] = "Не получилось добавить предмет"
    end
    redirect_to user_path(current_user)
  end

end
