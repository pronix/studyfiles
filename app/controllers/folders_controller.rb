# -*- coding: utf-8 -*-
class FoldersController < ApplicationController
  # before_filter :authenticate_user!
  before_filter :find_folder

  def index
  end

  def new
    @folder = Folder.new
  end

  def create
    @folder = Folder.new(params[:folder])
    if @folder.save
      flash[:notice] = "Папка успешно создана"
    else
      flash[:alert] = "Папка не создана!"
    end
    redirect_to folders_path
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
