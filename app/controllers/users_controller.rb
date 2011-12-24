class UsersController < ApplicationController
  before_filter :search, :only => :show

  def index
    @users = User.search(params[:search],
                         :star => true,
                         :page => params[:page],
                         :per_page => 5,
                         :order => :rank,
                         :sort_mode => :asc,
                         :without => {:rank => 0})
  end

  def show
    @user = User.find(params[:id])
    @news = Novelty.main
    render "users/search" if @documents
  end

  private
  
  def search
    return unless params[:search].present?
    @documents = Document.
      search(:conditions => {:txt_doc => params[:search],
               :user_id => params[:id]})
  end
  
end
