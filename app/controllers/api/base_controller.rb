class Api::BaseController < ActionController::API
  before_action :authenticate

  private

  def authenticate
    access_token = request.headers["JWTAuthorization"]
    @decoded = JsonWebToken.decode access_token&.split(" ")&.last
    @current_user = User.find @decoded.try(:[], :user_id)
    return render json: {success: false , data: nil}, status: 400 if (@decoded.nil? || @current_user.login_token != @decoded.try(:[], :login_token))
  end
end
