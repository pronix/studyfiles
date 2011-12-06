# -*- coding: utf-8 -*-
class FoldersController < ApplicationController
  before_filter :authenticate_user!

  def index
    @folders = current_user.folders
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
    @folder = Folder.find(params[:id])
    send_file @folder.zip_files, :type => "application/zip"
  end
end
