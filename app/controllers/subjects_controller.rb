# -*- coding: utf-8 -*-
class SubjectsController < ApplicationController

  before_filter :load_univer, :only => [:index, :new, :edit, :create, :show]

  def index
    @subjects = Subject.search(params[:search], :conditions => {:university_name => @university.name}, :with => {:section_id => 0})
  end

  def new
    @subject = @university.subjects.new
  end

  def edit
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

  def show
    @subject = @university.subjects.find(params[:id])
  end

  def create
    @subject = Subject.new(params[:subject])
    if @subject.save
      @university.subjects << @subject
      flash[:notice] = "Добавлен предмет"
    else
      flash[:alert] = "Не получилось добавить предмет"
    end
    redirect_to user_path(current_user)
  end

  private

  def load_univer
    @university = University.find(params[:university_id])
  end

end
