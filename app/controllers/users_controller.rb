class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[create]

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
      token = encode_token(login: @user.login)
      render json: { token: token }, status: :created
    else
      render json: @user.errors.full_messages , status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      render json: "Successfully updated", status: :ok
    else
      render json: "Error, check your data and try again", status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    render json: "User is successfully deleted", status: :ok
  end

  private
  def user_params
    params.require(:user).permit(:login, :password, :name)
  end

  def set_user!
    @user = User.find params[:id]
  end

end
