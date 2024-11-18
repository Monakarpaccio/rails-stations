class ApplicationController < ActionController::Base
  # Deviseのコントローラが使用される場合のみ、configure_permitted_parametersを実行
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
