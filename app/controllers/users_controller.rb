class UsersController < ApplicationController

  def index
    @users = User.all.sort_by{ |elem| elem.raiting }
  end

  def show
    @user = User.find(params[:id])
    @news = Novelty.main
  end
end
