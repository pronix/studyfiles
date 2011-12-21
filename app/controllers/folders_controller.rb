# -*- coding: utf-8 -*-
class FoldersController < ApplicationController
  # before_filter :authenticate_user!
  before_filter :find_folder, :only => [:download, :show]

  def index
  end

  def new
    @university = University.find(params[:university]) if params[:university]
    @subject = Subject.find(params[:subject]) if params[:subject]
    @parent = Folder.find(params[:parent_id]) if params[:parent_id]

    @folder = Folder.new(:user => current_user, :university => @university, :subject => @subject)
  end

  def create
    @folder = Folder.new(params[:folder])
    if @folder.save
      @folder.copy_to_folder(Folder.find(params[:parent])) if params[:parent]
      flash[:notice] = "Папка успешно создана"
    else
      flash[:alert] = "Папка не создана!"
    end
    redirect_to user_path(current_user)
  end

  def show
    @folder = Folder.find(params[:id])
    render :layout => 'previews'
  end

  def update
    @folder = (current_user.admin? ? Folder.find_by_id(params[:id]) : current_user.folders.find_by_id(params[:id]))
    if @folder.update_attributes(params[:folder])
      flash[:notice] = "Папка успешно изменена"
    else
      flash[:alert] = "Папка не изменена!"
    end
    redirect_to folders_path
  end

  def download
    unless current_user
      flash[:notice] = 'Для скачивания папок необхадимо зарегистрироваться'
      redirect_to_back and return
    end
    @folder = Folder.find(params[:id])
    current_user.download_object(@folder)
    send_file @folder.zip_folder, :filename => @folder.zip_name, :type => "application/zip"
  end

  def move

    folder = Folder.find(params[:destination])
    folder.move_files(params[:folder_ids], params[:document_ids])

    redirect_to request.referer
  end

  private

  def find_folder
    if params[:university_id].present?
      @university = University.find(params[:university_id])
      @folder = @university.folders.find(params[:id]) if params[:id].present?
    else
      @folder = Folder.find(params[:id])
    end
  end
end
