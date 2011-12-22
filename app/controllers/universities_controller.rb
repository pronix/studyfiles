# -*- coding: utf-8 -*-
class UniversitiesController < ApplicationController

  before_filter :get_right_column
  helper_method :parent

  #Главная страница
  def index
    @universities = University.
      search(params[:search], :star => true, :page => params[:page],
             :per_page => 4, :order => :rating, :sort_mode => :desc)
  end

  def search
    if params[:search].strip.length > 0
      @universities = University.
        search(:conditions => {:name => params[:search]},
               :star => true, :order => :rating, :sort_mode => :desc)
    else
      @universities = University.all
    end
  end


  def new
    @university = University.new
    @preview = ImagePreview.create
  end

  def edit
    @university = University.find(params[:id])
  end

  def update
    @university = University.find(params[:id])
    if @university.update_attributes(params[:university])
      redirect_to root_path
    else
      render :edit
    end
  end

  def create
    @preview = params[:preview_id] ? ImagePreview.find(params[:preview_id]) : nil
    @university = University.new(params[:university])
    if @university.save
        current_user.universities << @university
        if @preview
          @university.update_attributes(:logo => @preview.asset)
          @preview.destroy
        end
        flash[:notice] = "Добавлен университет"
    else
      flash[:alert] = "Не получилось добавить университет"
    end
    redirect_to user_path(current_user)
  end

  def preview_logo
    @preview = ImagePreview.new(params[:image_preview])
    responds_to_parent do |page|
      if @preview.save
        page << "$('#preview1').attr('src', '#{@preview.asset.url(:full)}')"
        page << "$('#preview2').attr('src', '#{@preview.asset.url(:thumb)}')"
        page << "$('#preview3').attr('src', '#{@preview.asset.url(:icon)}')"
        page << "$('#logo-previews').append('#{hidden_field_tag :preview_id, @preview.id}')"
      end
    end
  end

  def add_user
    @university = University.find(params[:id])
    current_user.universities << @university
    redirect_to request.referer
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
