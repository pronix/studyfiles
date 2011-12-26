class FilesController < ApplicationController
  before_filter :sort_order
  
  def index
    case params[:group]
    when 'subjects'
      @search = Subject.metasearch(params[:search])
      @subjects = @search
      render "subjects"
    when 'users'
      @search = User.metasearch(params[:search])
      @users = @search
      render 'users'
    else
      @search = University.metasearch(params[:search])
      @universities = @search
    end
  end

  def search
    @results = ThinkingSphinx.search params[:search_keyword],
    :conditions => {:university_name => params[:univer_name],
      :subject_name => params[:subject_name]},
    :classes => [Document, Folder]
  end

  private
  def sort_order
    if params[:search].present? and params[:search]['meta_sort'].present?
      @sort = params[:search]['meta_sort'].to_s.gsub('.', ' ')
    else
      @sort = 'name ASC'
    end
  end
end
