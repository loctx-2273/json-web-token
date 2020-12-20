class Api::V1::AuthenticateController < Api::BaseController
  skip_before_action :authenticate, only: :create
  before_action :load_user, only: :create

  def create
    generate_token @current_user
    render json: {message: "Login successfully", success: true, data: @data}, status: 200
  end

  def destroy
    @current_user.update_attributes login_token: nil
    render json: {message: "Logout successfully",success: true, data: nil}, status: 200
  end

  private
  def load_user
    @current_user = User.find_by email: params[:email]
  end
    
  def generate_token user
    login_token = SecureRandom.hex
    user.update_attributes login_token: login_token
    access_token = JsonWebToken.encode(user_id: user.id, login_token: login_token)

    @data = {
      access_token: access_token,
      token_type: "Bearer"
    }
  end
end
