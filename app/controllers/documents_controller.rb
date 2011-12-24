# -*- coding: utf-8 -*-
class DocumentsController < ApplicationController
  # before_filter :authenticate_user!

  def index
    @group = University.all
  end

  def new
    @user = User.find(params[:user_id])

    @university = University.find(params[:university]) if params[:university]
    @subject = Subject.find(params[:subject]) if params[:subject]
    @folder = Folder.find(params[:folder]) if params[:folder]

    @documents = Array.new(3) { @user.documents.build(:folder => @folder, :university => @university, :subject => @subject) }
  end

  def show
    @document = Document.find(params[:id])
    render :layout => 'previews'
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
    vote = Vote.where(conditions).first || Vote.create(conditions)
    type = params[:vote_type]

    vote.update_attributes(:vote_type => type)

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
