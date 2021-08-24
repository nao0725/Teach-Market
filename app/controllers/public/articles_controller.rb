class Public::ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = Article.all
    @user = User.find(params[:id])
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
    tag_list = params[:article][:tag_name].split("/")
    if @article.save
       @article.tags_save(tag_list)
       flash.now[:notice] =  "投稿されました"
       redirect_to home_path
    else
      @user = current_user
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def update
    if @article.update(article_params)
      tag_list = params[:article][:tag_name].split(",")
      @article.tags_save(tag_list)
      flash.now[:notice] = "投稿が更新されました"
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
