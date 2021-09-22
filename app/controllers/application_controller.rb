class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :help]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    home_path(resource)
  end

  #エラーページ出力の設定
  unless Rails.env.development?
  # unless Rails.env.production?
    rescue_from Exception,                      with: :_render_500
    rescue_from ActiveRecord::RecordNotFound,   with: :_render_404
    rescue_from ActionController::RoutingError, with: :_render_404
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  protected

  def _render_404(e = nil)
    logger.info "Rendering 404 with exception: #{e.message}" if e

    if request.format.to_sym == :json
      render json: {error: "404 Not Found" }, status: :not_found
    else
      render "errors/404.html", status: :not_found, lauout: "error"
    end
  end

  def _render_500(e = nil)
    logger.error "Rendering 500 with exception: #{e.message}" if e

    if request.format.to_sym == :json
      render json: {error: "500 Not Found" }, status: :internal_sever_error
    else
      render "errors/500.html", status: :internal_sever_error, lauout: "error"
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email])
  end
end
