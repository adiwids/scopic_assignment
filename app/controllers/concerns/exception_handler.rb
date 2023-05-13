module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :handle_bad_request
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  end

  def handle_bad_request(error)
    render json: { message: error.message }, status: :bad_request
  end

  def handle_not_found(error)
    render json: { message: error.message }, status: :not_found
  end
end
