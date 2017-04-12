class ApplicationController < ActionController::API
before_action :authenticate_user_from_token, except: [:token]
include ActionController::HttpAuthentication::Basic::ControllerMethods
include ActionController::HttpAuthentication::Token::ControllerMethods

 def default_serializer_options
   { root: false }
 end

 def token
  authenticate_with_http_basic do |email, password|
    user = User.find_by(email: email)
    if user && user.password == password
      render json: { token: user.auth_token }
    else
      render json: { error: 'Incorrect credentials' }, status: 401
    end
  end
 end

private
  def authenticate_user_from_token
  unless authenticate_with_http_token { |token, options| User.find_by(auth_token: token) }
    render json: { error: 'Bad Token'}, status: 401
  end
  end

end
