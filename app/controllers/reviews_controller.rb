class ReviewsController < ApplicationController
  before_action :set_review!, only: %i[show edit update destroy]

  #отредактировать на крепление фото
  def index
    render json: Review.all
  end

  def show
    render json: review_with_images(@review)
  end

  def new
    @review = Review.new
  end

  def create
    @review = Review.new review_params
    @review.user_id = $user.id
    if @review.save
      render json: "Successfully created", status: :created
    else
      render json: "Error, check your data and try again", status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @review.update review_params
      render json: "Successfully updated", status: :ok
    else
      render json: "Error, check your data and try again", status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    render json: "Your review is successfully deleted", status: :ok
  end

  private
  #remove abv
  def review_params
    params.require(:review).permit(:name, :rating, :price, :description, :producer, :abv)
  end

  def set_review!
    @review = Review.find params[:id]
  end

  def review_with_images(review)
    {
      id: review.id,
      name: review.name,
      rating: review.rating,
      price: review.price,
      description: review.description,
      producer: review.producer,
      abv: review.abv,
      user_id: review.user_id,
      images: review.images.map { |image| url_for(image) }
    }
  end

end
