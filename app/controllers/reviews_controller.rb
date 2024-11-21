class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    if @review.save
      redirect_to review_path(@review)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @reviews = Review.all
  end

  private

  def review_params
    params.require(:review).permit(
                                :rating,
                                :comment
                              )
  end
end
