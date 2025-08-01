class JwtService
  SECRET_KEY = Rails.application.credentials.secret_key_base || 'your-secret-key'

  def self.encode(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY)[0]
  rescue JWT::DecodeError
    nil
  end
end 