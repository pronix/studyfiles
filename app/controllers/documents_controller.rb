# -*- coding: utf-8 -*-
class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @folders = if params[:university]
               University.find(params[:university]).primary_folders
             else
               nil
             end
  end

  def new
    @user = User.find(params[:user_id])
    3.times { @user.documents.build }
  end

  def create
    @user = User.find(params[:user_id])
    @user.update_attributes(params[:user])
    @user.save
    #@files = params[:documents].collect { |file| @user.documents.new(file) }
    #if request.post? && @files.all?(&:valid?)
      #@files.each(&:save!)
   #   #if @file.item.content_type == 'application/zip'
      #  flash[:notice] = "Ваш архив принят на обработку"
      #else
      #  flash[:notice] = "Файл успешно создан"
      #end

    #else
     # flash[:alert] = "Файл не создан!"
   # end
    redirect_to user_path(@user)
  end

  def edit
    @file = Document.find_by_id(params[:id])
  end

  def update
    @file = (current_user.admin? ? Document.find_by_id(params[:id]) : current_user.documents.find_by_id(params[:id]))
    if @file.update_attributes(params[:document])
      flash[:notice] = "Файл успешно изменен."
    else
      flash[:alert] = "Файл не изменен!"
    end
    redirect_to documents_path
  end
end
