# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :set_address, only: %i[show edit update destroy]

  def index
    @addresses = @user.addresses
  end

  def show; end

  def new; end

  def create
    @address = @user.addresses.create(address_params)

    respond_to do |format|
      if @address.save
        format.html { redirect_to user_path(@user), notice: t('.create.success') }
        format.json { render :show, status: :created, location: @address }
      else
        format.html { redirect_to user_path(@user), notice: t('.create.error') }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to user_address_path(@user), notice: t('.update.success') }
        format.json { render :show, status: :ok, location: @address }
      else
        format.html { render :edit }
        format.json { render json: @address.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to user_path(@user), notice: t('.destroy.success') }
      format.json { head :no_content }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_address
    @address = @user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:street1, :street2, :city, :province, :zip_code, :country, :category)
  end
end
