class Public::ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy ]

  def index
    @articles = Article.published
    @user = User.find(params[:id])
  end

  def user_articles
    @user = User.find(params[:id])
    if current_user == @user
      @articles = @user.articles.page(params[:page]).per(10)
    else
      @articles = @user.articles.page(params[:page]).per(10).published
    end
  end

  def update_status
    @article = Article.find(params[:article_id])
    @article.update_status!
    redirect_to request.referer, notice: "ステータスを更新しました"
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
    tag_list = params[:article][:tag_name].split('/')
    if @article_form.valid?
      @article_form.save(tag_list)
      flash.now[:notice] = "投稿されました"
      redirect_to home_path
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
    tag_list = params[:article][:tag_name].split('/')
    if @article_form.valid?
      @article_form.save(tag_list)
      flash.now[:notice] = "更新されました"
      redirect_to article_path(@article)
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
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :body, :sub_title, :user_id, :article_id, :tag_name, :tag_id).merge(user_id: current_user.id)
  end

end
