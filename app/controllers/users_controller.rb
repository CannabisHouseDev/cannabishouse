class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def edit
  end

  def index
    @users = User.all
  end

  def update
    if @user.update_attributes(permitted_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def secure_params
    params.require(:user).permit!(:email, :password, :password_confirmation, address_attributes: [:id, :street1, :street2, :city, :province, :zip_code, :country, :type])
  end
end
