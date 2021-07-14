class AdminPortalController < ApplicationController

  def index
    @orders = Order.all.order("status ASC").order("id ASC")
    @order_details = OrderMaterial.all
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success] = "Company updated"
      redirect_to admin_dashboard_path
    else
      flash[:error] = "Nothing happened!"
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:status)
  end

end