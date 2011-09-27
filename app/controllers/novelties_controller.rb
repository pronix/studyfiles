class NoveltiesController < ApplicationController

  #список новостей
  def index
    @news = Novelty.all
  end

end
