# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]



  # GET /resource/sign_in
  def new
    session.delete('devise.omniauth_data')
    super
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def new_guest
    user = User.guest
    sign_in user
    redirect_to home_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.

   #退会後のログインを阻止
   def reject_user
    @user = User.find_by(nickname: params[:user][:nickname])
    if @user
      if (@user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false))
        flash[:error] = "退会済みです。"
        redirect_to new_user_session_path
      end
    else
      flash[:error] = "必須項目を入力してください。"
    end
  end
end
