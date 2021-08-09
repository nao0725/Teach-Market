class Public::ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = Article.all
  end

  def show
    @comment = Comment.new
    @comments = @article.comments
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    tag_list = params[:article][:tag_name].split(",")
    if @article.save
       @article.tags_save(tag_list)
       redirect_to home_path
    else
      @user = current_user
      render :new
    end
  end

  def update
    if @article.update(article_params)
      @article.tags_save(tag_list)
      flash[:notice] = "You have updated article successfully."
      redirect_to article_path
    else
      @user = current_user
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to home_path
  end

  private

    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body, :sub_title)
    end

end
