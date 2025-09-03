
class AccountsController < ApplicationController

  # the user must log in
  before_action :authenticate_user!
  def show
  end

  # user can edit information
  def edit
    @user = current_user
  end

  # update the user accout
  def update
    @user = current_user
    if @user.update(account_params)
      redirect_to account_path, notice: "Information updated"
    else
      render :edit
    end
  end

  private
  def account_params
    params.require(:user).permit(:email, :username, :introduction)
  end
end
