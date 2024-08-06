class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @perfume = Perfume.find(params[:perfume_id])
    @review = Review.new(review_params)
    @review.perfume = @perfume
    @review.user_id = current_user.id

    if @review.save
      redirect_to perfume_path(@review.perfume), notice: 'Avis ajouté avec succes'
    else
      redirect_to perfume_path(@review.perfume), alert: 'Impossible de mettre un avis'
    end
  end

  private

  def review_params
    params.require(:review).permit(:perfume_id, :comment, :rating)
  end
end
