class FilesController < ApplicationController
  before_filter :sort_order
  
  def index
    @universities = University.
      search(params[:search],
             :without => {:available => false},
             :star => true, :order => @order, :sort_mode => @sort_a)
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
