class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate_user!

  # Generic index method that returns a list of data with JSON serializers
  def index
    model_class = controller_name.classify.constantize
    serializer_class = "#{controller_name.classify.pluralize}Serializer".constantize
    
    @records = model_class.all
    render json: serializer_class.new(@records)
  end

  # Generic show method that returns single data with JSON serializers
  def show
    model_class = controller_name.classify.constantize
    serializer_class = "#{controller_name.classify.pluralize}Serializer".constantize
    
    @record = model_class.find(params[:id])
    render json: serializer_class.new(@record)
  end

  private

  def authenticate_user!
    authenticate_or_request_with_http_token do |token, options|
      @current_user = find_user_from_token(token)
    end
  end

  def find_user_from_token(token)
    payload = JwtService.decode(token)
    return nil unless payload

    User.find_by(id: payload['user_id'])
  end

  def current_user
    @current_user
  end

  def generate_token(user)
    JwtService.encode(user_id: user.id)
  end
end
