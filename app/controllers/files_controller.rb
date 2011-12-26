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
    univer_filter = params[:univer_filter].present? ? {:university_name => params[:univer_filter]} : {}
    subject_filter = params[:subject_filter].present? ? {:subject_name => params[:subject_filter]} : {}
    result_filter = univer_filter.merge(subject_filter)
    @documents = Document.search(params[:search_keyword],
                                 :conditions => {}.merge(result_filter))
    @folders = Folder.search(params[:search_keyword],
                                 :conditions => {}.merge(result_filter))
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
