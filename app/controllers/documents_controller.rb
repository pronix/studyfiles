# -*- coding: utf-8 -*-
class DocumentsController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @group = University.all
  end

  def new
    @university = University.find(params[:university]) if params[:university]
    @subject = Subject.find(params[:subject]) if params[:subject]
    @folder = Folder.find(params[:folder]) if params[:folder]

    @user = User.find(params[:user_id])
  end

  def show
    @document = Document.find(params[:id])
    render :layout => 'previews'
  end

  def create
    @user = User.find(params[:user_id])

    file = params[:Filedata]

    @university = University.find(params[:university]) if params[:university]
    @subject = Subject.find(params[:subject]) if params[:subject]
    @folder = Folder.find(params[:folder]) if params[:folder]

    @doc = Document.new(:item => file,
                        :user => @user,
                        :folder => @folder,
                        :university => @university,
                        :subject => @subject)
    @doc.save

    #flash[:notice] = "Обрабатываются файлы: #{@user.get_new_documents_names(params[:user][:documents_attributes].size)}. После обработки они появятся в списке ваших файлов."
    redirect_to user_path(@user)
  end

  def edit
    @file = Document.find_by_id(params[:id])
  end

  def update
    @document = Document.find(params[:id])
    @document.update_attributes(params[:document])
    redirect_to user_path(@document.user), notice: "Файл обновлен"
  end

  def download
    @doc = Document.find_by_id(params[:id])

    conditions = { :document_id => @doc.id, :user_id => (current_user ? current_user.id : nil) }

    if Vote.where(conditions).empty?
      vote = Vote.create(conditions)
      vote.update_attributes(:grade => 1, :vote_type => true)
      cookies["download_finished"] = { :value => "true", :expires => 1.second.from_now }
    end
    current_user.download_object @doc if current_user
    send_file(@doc.item.path, :filename => @doc.item_file_name)
  end

  def rate
    @doc = Document.find(params[:id])

    conditions = { :document_id => @doc.id, :user_id => current_user.id }

    type = params[:vote_type]

    if Vote.where(conditions).first
      Vote.where(conditions).first.update_attributes(:vote_type => type)
    else
      Vote.create(conditions.merge({:vote_type => type}))
    end

    if params[:redirect_to]
      redirect_to params[:redirect_to]
    else
      redirect_to request.referer
    end
  end


  def destroy
    @doc = Document.find(params[:id])
    @doc.destroy
    flash[:notice] = "Файл удалён."
    redirect_to request.referer
  end

end
