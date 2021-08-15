class Admins::UsersController < ApplicationController
  def index
    @users = User.all
  end
  
   before_action :authenticate_user!
   before_action :set_user
   before_action :correct_user, only: [:edit, :update]

  def show
    @articles = @user.articles.page(params[:page]).per(3)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :nickname, :introduction)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

end
