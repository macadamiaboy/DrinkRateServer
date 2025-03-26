class ReviewsController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_review!, only: %i[show edit update destroy]

  def show
    render json: @review
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new review_params
    if @review.save
      render json: "Successfully created", status: :created
    else
      render json: "Error, check your data and try again"
    end
  end

  def edit
  end

  def update
    if @review.update review_params
      render json: "Successfully updated"
    else
      render json: "Error, check your data and try again"
    end
  end

  def destroy
    @review.destroy
    render json: "Your review is successfully deleted"
  end

  private

  def review_params
    params.require(:review).permit(:name, :rating, :price, :description, :producer, :abv, :user_id)
  end

  def set_review!
    @review = Review.find params[:id]
  end

end
