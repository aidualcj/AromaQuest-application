class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]
  before_action :set_locale, only: [:show, :index]

  def create
    @order = current_user.orders.build
    @order.status = 'pending'
    @order.total = calculate_total_with_delivery

    if @order.save
      current_user.cart.cart_items.each do |cart_item|
        @order.order_items.create(perfume: cart_item.perfume, quantity: cart_item.quantity, price: cart_item.perfume.price)
      end
      current_user.cart.cart_items.destroy_all
      redirect_to @order, notice: 'Votre commande a été passée avec succès.'
    else
      redirect_to cart_path, alert: 'Impossible de passer la commande.'
    end
  end

  def show
    @order_items = @order.order_items
    @total_price = @order_items.sum { |item| item.price * item.quantity }
    @delivery_fee = @total_price * 0.10
    @total_with_delivery = @total_price + @delivery_fee
  end

  def index
    @orders = current_user.orders
  end

  private

  def set_locale
    I18n.locale = :fr
  end

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def calculate_total_with_delivery
    total = current_user.cart.cart_items.sum { |item| item.quantity * item.perfume.price }
    delivery_fee = total * 0.10
    total + delivery_fee
  end
end
