# -*- coding: utf-8 -*-
class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @group = University.all
  end

  def new
    @user = User.find(params[:user_id])
    @documents = Array.new(3) { @user.documents.build }
  end

  def create
    @user = User.find(params[:user_id])

    @user.update_attributes(params[:user])
    flash[:notice] = "Обрабатываются файлы: #{@user.get_new_documents_names(params[:user][:documents_attributes].size)}. После обработки они появятся в списке ваших файлов."
    redirect_to user_path(@user)
    #else
    #  flash[:notice] = "Ошибка!"
    #  render :action => "new"
    #end
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

  def download
    @doc = Document.find_by_id(params[:id])
    send_file(@doc.item.path, :filename => @doc.item_file_name)
  end

end
