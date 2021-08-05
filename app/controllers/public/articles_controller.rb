class Public::ArticlesController < ApplicationController
  before_action :set_article, only: [ :show, :edit, :update, :destroy ]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(public_article_params)
  end

  #   respond_to do |format|
  #     if @public_article.save
  #       format.html { redirect_to @public_article, notice: "Article was successfully created." }
  #       format.json { render :show, status: :created, location: @public_article }
  #     else
  #       format.html { render :new, status: :unprocessable_entity }
  #       format.json { render json: @public_article.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /public/articles/1 or /public/articles/1.json
  # def update
  #   respond_to do |format|
  #     if @public_article.update(public_article_params)
  #       format.html { redirect_to @public_article, notice: "Article was successfully updated." }
  #       format.json { render :show, status: :ok, location: @public_article }
  #     else
  #       format.html { render :edit, status: :unprocessable_entity }
  #       format.json { render json: @public_article.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /public/articles/1 or /public/articles/1.json
  # def destroy
  #   @public_article.destroy
  #   respond_to do |format|
  #     format.html { redirect_to public_articles_url, notice: "Article was successfully destroyed." }
  #     format.json { head :no_content }
  #   end
  # end

  private
  
    def set_article
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :body)
    end
end
