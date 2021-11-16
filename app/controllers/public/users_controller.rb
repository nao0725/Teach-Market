class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_user, except: [:index]
  before_action :correct_user, only: [:edit, :update]

  def index
    redirect_to new_user_registration_path
  end

  def show
  end

  def edit
    redirect_to request.referer if current_user.id == User.guest.id
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  
  def following
    @user  = User.find(params[:following_id])
    @users = @user.following
  end

  def followers
    @user  = User.find(params[:followers_id])
    @users = @user.followers
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
