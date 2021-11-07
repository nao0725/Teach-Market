class Public::ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = Article.all
    @user = User.find(params[:id])
  end

  def show
    @comment = Comment.new
    @comments = @article.comments
    @user = User.guest
  end

  def new
    @article_form = ArticleForm.new
  end

  def create
    @article_form = ArticleForm.new(article_params)
    if @article_form.valid?
      @article_form.save
      flash.now[:notice] = "投稿されました"
      redirect_to article_path(@article_form)
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new
    end
  end

  def edit
    @article_form = ArticleForm.new(article: @article)
  end


  def update
    @article_form = ArticleForm.new(article_params, article: @article)
    if @article_form.valid?
      @qrticle_form.save
      flash.now[:notice] = "更新されました"
      redirect_to article_path(@article_form)
    else
      flash.now[:alert] = "更新に失敗しました"
      render :new
    end
  end

  def destroy
    @article.destroy
    redirect_to home_path
  end

  private

  def set_article
    @article = Article.includes(:tags).find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :sub_title, tags_attributes: [:tag_name])
  end

end
