class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  SECRET_SALT = 'supersecretkey'

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authorized

  def encode_token(payload)
    JWT.encode(payload, SECRET_SALT, 'HS256')
  end

  def decoded_token
    header = request.headers['X-Auth-Token']
    if header
      token = header.split(" ")[1]
      #render json: token
      begin
        JWT.decode(header, SECRET_SALT, true, { algorithm: 'HS256' }) #changed token to header
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      login = decoded_token[0]['login']
      $user = User.find_by(login: login)
    end
  end

  def authorized
    unless !!current_user
      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end
end
