class WelcomeController < ApplicationController
  before_action :authenticate_admin!, only:[:dashboard]
  
  def index
     @article = Article.paginate(page: params[:page], per_page:3).all
  end
  
  def create
    Article.create()
  end
  
  def buscar
    @articulo = Article.find(params[:id])
  end
  
  def dashboard
     @article = Article.paginate(page: params[:page], per_page:9).all
  end
end
