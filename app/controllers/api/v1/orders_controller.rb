class Api::V1::OrdersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_order, only: %i[ show edit update destroy paid canceled]
  
  def show
    @order_detail = @order.order_details
    render json: {
      order: @order,
      menus: @order.menus
    }
  end

  def index
    @orders = Order.all
    @response = []
    @orders.each do |order|
      @response << {
        order: order,
        menus: order.menus,
        order_detail: order.order_details
      }
    end

    render json: {
      order: @response
    }
  end

  def new
    order = Order.new(order_params)
    order.create_menu(menu_order_params[:menus])
  end

  def edit
  end

  def create
    @order = Order.new(order_params)
    @order.create_menu(menu_order_params[:menus])
    @order.sum_subtotal
    @order.sum_total
    @order.save

    render json:{
      order: @order,
      menus: @order.menus
    }
  end

  def destroy
    @order.order_details.destroy_all
    @order.destroy
    render json: @order, status:200
  end

  def paid
    @order.set_status_paid
    render json:{
      order: @order,
      menus: @order.menus
    }
  end

  def canceled
    @order.set_status_canceled
    render json:{
      order: @order,
      menus: @order.menus
    }
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

  def set_status_paid
    self.update(status: "PAID")
  end

  def set_status_canceled
    self.update(status: "CANCELED")
  end
end
