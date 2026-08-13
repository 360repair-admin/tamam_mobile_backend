class Api::BaseController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_validation_error

  skip_forgery_protection
  wrap_parameters false

  include Authentication

  private

  def render_not_found(exception)
    render json: {
      error: {
        code: "not_found",
        message: exception.message
      }
    }, status: :not_found
  end

  def render_validation_error(exception)
    render json: {
      error: {
        code: "validation_error",
        message: exception.record.errors.full_messages
      }
    }, status: :unprocessable_entity
  end
end
