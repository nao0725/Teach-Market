class Public::UsersController < ApplicationController
   before_action :authenticate_user!
   before_action :correct_user, only: [:edit, :update]

  def show
  end

  def edit
  end

  def update
  end

  private

  def 
  end

end
  
end
