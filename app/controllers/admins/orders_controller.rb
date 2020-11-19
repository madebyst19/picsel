class Admins::OrdersController < ApplicationController
  def index
    @orders = Order.all
  end

  def show
      @order = Order.find(params[:id])
      @order_details = OrderDetail.where(order_id: @order.id)
  end
end
