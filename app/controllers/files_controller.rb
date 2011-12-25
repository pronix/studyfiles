class FilesController < ApplicationController
  before_filter :sort_order
  
  def index
    unless params[:group_by].present?
      @universities = University.
      search(:without => {:available => false},
             :order => :rating, :sort_mode => :desc)
    else
      case params[:group_by]
      when 'subjects'
        @subjects = Subject.search
        render "subjects"
      when 'users'
        @users = User.search(:star => true, :order => @order,
                             :sort_mode => @sort_a)
        render "users"
      end
    end
  end

  def search
    @results = ThinkingSphinx.search params[:search],
    :classes => [Document, Folder]
  end

  private
  def sort_order
    if @sort = params[:sort]
      if @sort == 'rating DESC'
        @order = :rating
        @sort_a = :desc
      end
    else
      @sort = ''
      @order = :rating
      @sort_a = :desc
    end
  end
end
