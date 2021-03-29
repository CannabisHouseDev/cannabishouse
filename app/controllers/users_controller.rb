class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :new, :edit, :update, :destroy]
  before_action :configure_permitted_parameters
  def new
    @addresses = @user.addresses.build
  end

  def edit
  end

  def index
    @users = User.all
  end

  def update
    byebug
    if @user.update(permitted_parameters)
      byebug
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
    params.require(:user).permit!(:email, :password, :password_confirmation, :role, :first_name, :last_name, :pesel, :is_men, :skills, :illness, :contact_number, :avatar, :birth_date, addresses_attributes: [:id, :street1, :street2, :city, :province, :zip_code, :country, :category])
  end

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :role, :first_name, :last_name, :pesel, :is_men, :skills, :illness, :contact_number, :avatar, :birth_date, addresses_attributes: [:id, :street1, :street2, :city, :province, :zip_code, :country, :category]])
  # end
  
end
