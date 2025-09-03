
# redefine the change password and refacotor the update method from divise
class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!

  # PATCH /users
  def update
    resource_updated = resource.update_with_password(account_update_params)
    if resource_updated
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password?
      redirect_to after_update_path_for(resource), notice: "password updated"
    else
      clean_up_passwords resource
      set_minimum_password_length
      render :edit
    end
  end

  protected
  def account_update_params
    params.require(:user)
          .permit(:password, :password_confirmation, :current_password)
  end

  def after_update_path_for(_)
    account_path
  end
end
