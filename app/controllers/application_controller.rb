class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def header
    @notifications = current_user.passive_notifications.all
    @notification =  @notifications.where.not(visitor_id: current_user.id)
  end


  def after_sign_in_path_for(resource)
   home_path(resource)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:email])
  end

  def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
