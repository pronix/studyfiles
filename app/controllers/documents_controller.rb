# -*- coding: utf-8 -*-
class DocumentsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @files = current_user.documents
  end

  def new
    @file = Document.new
  end

  def create
    @file = Document.new(params[:document])
    if request.post? && @file.save
      if @file.item.content_type == 'application/zip'
        flash[:notice] = "Ваш архив принят на обработку"
      else
        flash[:notice] = "Файл успешно создан"
      end
      
    else
      flash[:alert] = "Файл не создан!"
    end
    redirect_to documents_path
  end

  def edit
    @file = Document.find_by_id(params[:id])
  end

  def update
    @file = Document.find_by_id(params[:id])
    if @file.update_attributes(params[:document])
      flash[:notice] = "Файл успешно изменен."
    else
      flash[:alert] = "Файл не изменен!"
    end
    redirect_to documents_path
  end
end
