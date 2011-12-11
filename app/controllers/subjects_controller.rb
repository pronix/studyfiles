# -*- coding: utf-8 -*-
class SubjectsController < ApplicationController

  def index
    @university = University.find(params[:university_id])
    @subjects = Subject.search(params[:search], :conditions => {:university_name => @university.name})
  end

  def new
    @university = University.find(params[:university_id])
    @subject = @university.subjects.new
  end

  def edit
    @university = University.find(params[:university_id])
    @subject = @university.subjects.find(params[:id])
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      redirect_to university_subjects_path(:university_id => params[:university_id])
    else
      render :edit
    end
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
