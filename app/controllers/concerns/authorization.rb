module Authorization
  extend ActiveSupport::Concern

  included do
    include ActionController::HttpAuthentication::Token::ControllerMethods
  end

  protected

  def authenticate_token!
    authorization_header_token = nil
    @token_authenticated = authenticate_with_http_token do |token, options|
      authorization_header_token = token

      begin
        token.eql?(Rails.application.credentials[:authorization_token])
      rescue ArgumentError => _error
        # TODO: convert any exception to return HTTP 401
        false
      end
    end

    unless token_authenticated?
      authorization_header_token = "(blank)" if authorization_header_token.blank?
      render(json: { message: "Invalid value for authorization token: #{authorization_header_token}" }, status: :unauthorized)
      return
    end
  end

  def token_authenticated?
    !!@token_authenticated
  end
end
