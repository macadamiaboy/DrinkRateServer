class UsersController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_user!, only: %i[show edit update destroy]

  def show
    render json: @user
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      render json: "Successfully created", status: :created
    else
      render json: "Error, check your data and try again"
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      render json: "Successfully updated"
    else
      render json: "Error, check your data and try again"
    end
  end

  def destroy
    @user.destroy
    render json: "Your review is successfully deleted"
  end

  private
  def user_params
    params.require(:user).permit(:login, :password, :name)
  end

  def set_user!
    @user = User.find params[:id]
  end

end
