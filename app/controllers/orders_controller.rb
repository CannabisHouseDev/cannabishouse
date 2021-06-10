class OrdersController < ApplicationController
  before_action :set_user

  def index
    @orders = @user.orders
  end


  private

  def set_user
    @user = User.find(params[:user_id])
  end

end