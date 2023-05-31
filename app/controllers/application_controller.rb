class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :authenticate_user!
    before_action :configure_permitted_parameters, if: :devise_controller?
    #include Pundit::Authorization

    protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :middle_name, :phone_number, :country, :admin])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:tos_agreement])
  end
    
  def after_sign_in_path_for(resource)
    if resource.admin?
      camps_path
    else
      user_select_camp_path(current_user)
    end
  end
end
