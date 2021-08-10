class Public::UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :set_user
   before_action :correct_user, only: [:edit, :update]

  def show
    @articles = Article.where.not(body:nil, title:nil)
  end

  def edit
  end

  def update
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

end
