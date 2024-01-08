class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    #get params
    @article = Article.new(article_params)
    uploader = AvatarUploader.new

    if @article.save
      redirect_to @article
    else
  render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end


  private 
    def article_params
      #title and body strong typing
      params.require(:article).permit(:title, :body, :status, :image)
    end
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end

    def image_params
      params.require(:article).permit(:image)
    end
end
