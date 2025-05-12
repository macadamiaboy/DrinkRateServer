class AuthController < ApplicationController
  SECRET_SALT = 'supersecretkey'

  def login
    user = User.find_by(login: params[:login])
    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def generate_token(payload)
    JWT.encode(payload, SECRET_SALT, 'HS256')
  end
end