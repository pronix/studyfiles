class UniversitiesController < ApplicationController

  before_filter :get_right_column

  #Главная страница
  def index
    @universities = University.limit(3).order(:city)
  end

  #Поиск университетов по названию и предеметам
  def search
    @universities = University.where(["name LIKE ?", "%"+params[:text]+"%"])
    subjects = Subject.where(["name LIKE ?", "%"+params[:text]+"%"])
    subjects.each { |subject|
      @universities = @universities | subject
    }
  end

  private

  #строим правый сайдбар с новостями и топ-10
  def get_right_column
    @news = Novelty.where(:main => true)
    @stats = {:universtites => University.count,
              :subjects     => Subject.count,
              :files        => Document.count,
              :file_size    => Document.sum(:item_file_size),
              :users        => User.count
    }
  end

end
