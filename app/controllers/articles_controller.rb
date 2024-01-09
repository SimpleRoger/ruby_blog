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
    @article = Article.new(article_params.except(:tags))
    tags = params.dig(:article, :tags)&.split(',')

    uploader = AvatarUploader.new
    if @article.save
      create_or_delete_posts_tags(@article, tags)
      redirect_to @article
    else
  render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.new(article_params.except(:tags))
    tags = params.dig(:article, :tags)&.split(',')
    if @article.update(article_params.except(:tags))
      create_or_delete_posts_tags(@article, tags)
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

  def create_or_delete_posts_tags(article, tags) 
    # destory all tagables
    article.taggables.destroy_all if article.persisted?
    # tags = tags.strip.split(',') unless tags.nil?
    tags.each do |tag| 
      # append tag

      article.taggables.create(tag: Tag.find_or_create_by(name: tag))
    end
  end




  private 
    def article_params
      #title and body strong typing
      params.require(:article).permit(:title, :body, :status, :image, :tags)
    end
    def comment_params
      params.require(:comment).permit(:commenter, :body, :status)
    end

    def image_params
      params.require(:article).permit(:image)
    end
end
