module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    include Response

    rescue_from ActionController::ParameterMissing, with: :handle_bad_request
  end

  def handle_bad_request(error)
    render json: { message: error.message }, status: :bad_request
  end
end
