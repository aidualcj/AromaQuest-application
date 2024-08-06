class PerfumesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @perfumes = Perfume.all

    if params[:intensity].present?
      @perfumes = @perfumes.where(intensity: params[:intensity])
    end

    if params[:heart_note].present?
      @perfumes = @perfumes.joins(:notes).where("notes.coeur ILIKE ?", "%#{params[:heart_note]}%")
    end

    if params[:head_note].present?
      @perfumes = @perfumes.joins(:notes).where("notes.tete ILIKE ?", "%#{params[:head_note]}%")
    end

    if params[:base_note].present?
      @perfumes = @perfumes.joins(:notes).where("notes.fond ILIKE ?", "%#{params[:base_note]}%")
    end

    case params[:sort]
    when 'price_asc'
      @perfumes = @perfumes.order(price: :asc)
    when 'price_desc'
      @perfumes = @perfumes.order(price: :desc)
    end

    @head_notes = Note.distinct.pluck(:tete).map { |n| n.split(', ') }.flatten.uniq
    @heart_notes = Note.distinct.pluck(:coeur).map { |n| n.split(', ') }.flatten.uniq
    @base_notes = Note.distinct.pluck(:fond).map { |n| n.split(', ') }.flatten.uniq
  end
  def show
    @perfume = Perfume.find(params[:id])
    @review = Review.new
    address = current_user.address
    @magasins = Magasin.near(address, 10)
    @markers = @magasins.geocoded.map do |magasin|
      {
        lat: magasin.latitude,
        lng: magasin.longitude,
        marker_html: render_to_string(partial: "marker")
      }
    end
  end
end
