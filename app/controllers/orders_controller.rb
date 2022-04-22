class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  def show
    @order_detail = @order.order_details
  end

  def index
    @orders = Order.all
  end

  def new
    order = Order.new(order_params)
    order.create_menu(menu_order_params[:menus])
  end

  def edit
  end

  private

  def set_order
    @order = Order.find_by(id: params[:id])
  end

  def order_params
    params.require(:order).permit(:customer_email, :order_date)
  end

  def menu_order_params
    params.require(:order).permit(menus: [:id, :qty])
  end
end
