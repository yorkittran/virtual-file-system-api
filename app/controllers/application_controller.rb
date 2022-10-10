require 'json_web_token'

class ApplicationController < ActionController::Base
  def current_user
    user_payload = JsonWebToken.decode(access_token)
    User.find_by(user_payload) if user_payload
  end

  private

  def auth_header
    request.headers['Authorization']
  end

  def access_token
    auth_header&.split(' ')&.last
  end
end
