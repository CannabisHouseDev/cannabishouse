class OrdersController < ApplicationController
   before_action :set_order

  def index
    @orders = Order.all
  end

  def show
  end


  private

  def set_order
    @order = Order.find(params[:id])
  end

end