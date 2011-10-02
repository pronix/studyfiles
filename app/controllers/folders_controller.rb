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
    @folder = Folder.find_by_id(params[:id])
    if @folder.user == current_user || current_user.admin?
      if @folder.update_attributes(params[:folder])
        flash[:notice] = "Папка успешно изменена"
      else
        flash[:alert] = "Папка не изменена!"
      end
    end
    redirect_to folders_path
  end
end
