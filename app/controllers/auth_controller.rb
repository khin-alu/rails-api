class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [:login]

  def login
    user = User.find_by(email: params[:email])
    
    if user
      token = generate_token(user)
      render json: {
        token: token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email
        }
      }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def me
    render json: {
      user: {
        id: current_user.id,
        name: current_user.name,
        email: current_user.email
      }
    }
  end
end 