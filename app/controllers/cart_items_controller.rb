class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    perfume = Perfume.find(params[:perfume_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(perfume: perfume)
    @cart_item.quantity = (@cart_item.quantity || 0) + 1

    if @cart_item.save
      redirect_to request.referrer, notice: 'Parfum ajouté au panier'
    else
      redirect_to request.referrer, alert: 'Impossible d\'ajouter le parfum au panier'
    end
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])
    if @cart_item.update(cart_item_params)
      redirect_back fallback_location: root_path, notice: 'Panier mis à jour avec succès'
    else
      redirect_back fallback_location: root_path, alert: 'Impossible de mettre à jour le panier'
    end
  end

  def destroy
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_back fallback_location: root_path, notice: 'Parfum retiré du panier'
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
