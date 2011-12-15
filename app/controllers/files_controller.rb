class FilesController < ApplicationController
  def index
    @search = University.metasearch(params[:search] || {"meta_sort"=>"rating.desc"})
    @universities = @search
  end
end
