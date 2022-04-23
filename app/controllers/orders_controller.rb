before_action :set_order, only: %i[ show edit update destroy paid canceled]
  
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

  def create
    @order = Order.new(order_params)
    @order.create_menu(menu_order_params[:menus])
    @order.sum_subtotal
    @order.sum_total
    @order.save
  end

  def destroy
    @order.order_details.destroy_all
    @order.destroy
  end

  def paid
    @order.set_status_paid
  end

  def canceled
    @order.set_status_canceled
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