

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected


  def configure_permitted_parameters
    # Permit username and introduction when signing up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :introduction])
    
    # Permit username and introduction when updating account
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :introduction])
  end


  # Redirect to books page after successful login
  def after_sign_in_path_for(resource)
    books_path
  end


  # Redirect to books page after logout
  def after_sign_out_path_for(resource_or_scope)
    books_path
  end
end
