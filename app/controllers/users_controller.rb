class UsersController < ApplicationController
  before_action :set_user, only: %i[ update destroy ]
  skip_before_action :authenticate_user!, only: [:create, :register]

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      token = generate_token(@user)
      render json: {
        token: token,
        user: {
          id: @user.id,
          name: @user.name,
          email: @user.email
        }
      }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # POST /users/register (alias for create)
  def register
    create
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.expect(user: [ :name, :email ])
    end
end
