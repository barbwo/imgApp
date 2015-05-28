class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  def index
  	if signed_in?
  		@picture = current_user.pictures.build
      @my_last_items = current_user.pictures.limit(6)
  	end
  end
protected
def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nick <<:name
    devise_parameter_sanitizer.for(:account_update) << :nick << :name
  end
end

