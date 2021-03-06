class Admins::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :edit, :admins]
  before_action :set_user, except: [:index, :admins]
  before_action :correct_user, only: [:edit, :update]

  def admins
    redirect_to new_admin_registration_path
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @articles = @user.articles.page(params[:page]).per(5)
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
    params.require(:user).permit(:profile_image, :name, :nickname, :introduction, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end
end
