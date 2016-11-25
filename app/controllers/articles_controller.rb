class ArticlesController < ApplicationController
  #before_action :validate_user, except:[:show ,:index]
  before_action :authenticate_user!, except:[:show ,:index]
  before_action :set_article, except:[:index,:new,:create]
  before_action :authenticate_editor! , only:[:new, :create, :update]
  before_action :authenticate_admin!, only:[:destroy, :publish]
  
  def index
    #@article = Article.all
    @article = Article.publicados.paginate(page: params[:page], per_page:3).all
  end #end index
  
  # show articles  
  def show
    @article.update_visits_count
    @comment = Comment.new
    #Article.where.not("body = ? ", params[:id] )
    #Article.where("body LIKE ? OR title = ? ", "%hola%", params[:title] )
  end #end show

  #nuevo articulo
  def new
    @article = Article.new
    @categories = Category.all
  end # end new

  #crear articulos
  def create
     @article = current_user.articles.new( article_params )
     @article.categories = params[:categories]
      #raise params.to_yaml
      if @article.save
        redirect_to @article
      else
        render :new
      end  
  end #end crear

  #update articles
  def update
    @article.update_attributes(article_params)
    redirect_to @article
  end #end update
    
  def publish
    @article.publish!
    redirect_to @article
  end  
  #eliminar articulos
  def destroy
    @article.destroy
    redirect_to articles_path
  end #end destroy
  
  #edit article
  def edit
  end
  
  #private methods 
  private
  
  def set_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :body, :categories)
  end  
  
  def validate_user
    redirect_to new_user_session_path, notice:"Necesitas iniciar sesión."
  end
  
end
