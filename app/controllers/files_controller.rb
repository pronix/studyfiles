class FilesController < ApplicationController
  def index
    @search = University.metasearch(params[:search] || {"meta_sort"=>"rating.asc"})
    @universities = @search
  end
end
