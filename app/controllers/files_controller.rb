class FilesController < ApplicationController
  def index
    @universities = University.
      search(params[:search],
             :without => {:available => false},
             :star => true, :page => params[:page],
             :per_page => 15, :order => :rating, :sort_mode => :desc)
  end

  def search
    @results = ThinkingSphinx.search params[:search],
    :classes => [Document, Folder]
  end
end
