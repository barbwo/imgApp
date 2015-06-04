class ApplicationController < ActionController::Base
  # Prevent CSRF(cross-site request forgery) attacks by raising an exception.
  # Include the security token in requests and verify it on the server.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Brak dostępu!"
    redirect_to root_path
  end

  def index
  	if signed_in?
  		@picture = current_user.pictures.build
      @last_items = current_user.pictures.limit(6)
      @liked_items = current_user.liked_pictures.limit(6)
      @followed_items = current_user.feed.limit(6)
  	end
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :nick <<:name
    devise_parameter_sanitizer.for(:account_update) << :nick << :name
  end
end

