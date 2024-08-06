class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def index
    @favorites = current_user.favorites.includes(:perfume)
  end

  def create
    @favorite = Favorite.new(perfume_id: params[:perfume_id])
    @favorite.user_id = current_user.id
    if @favorite.save
      render json: { favorite: true, notice: 'Ajouté à vos favoris' }
    else
      render json: { favorite: false, alert: 'Impossible de rajouter aux favoris' }
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    @favorite.destroy
    if @favorite.destroyed?
      redirect_to favorites_dashboard_path, notice: 'Supprimé des favoris'
    else
      redirect_to favorites_dashboard_path, alert: 'Favori introuvable'
    end
  end
end
