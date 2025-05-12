class AuthController < ApplicationController
  skip_before_action :authorized

  def login
    user = User.find_by(login: params[:login])
    if user&.authenticate(params[:password])
      token = encode_token(login: user.login)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end
end