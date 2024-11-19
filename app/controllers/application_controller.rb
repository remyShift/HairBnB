class ApplicationController < ActionController::Base
  before_action :set_ressource
  before_action :configure_sign_up_params, only: [:create]
  
  protected

  def set_ressource
    @resource = User.new
    @resource_name = :user
  end
  
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end
end
