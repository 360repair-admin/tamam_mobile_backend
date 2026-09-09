class Api::BaseController < ApplicationController
  SUPPORTED_LOCALES = %w[ar en].freeze

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :render_validation_error

  skip_forgery_protection
  wrap_parameters false

  include Authentication

  around_action :set_locale

  private

  def set_locale(&action)
    locale = request.headers["Accept-Language"]
      .to_s
      .downcase
      .split(",")
      .first
      .to_s
      .split("-")
      .first

    locale = :ar unless SUPPORTED_LOCALES.include?(locale)

    I18n.with_locale(locale, &action)
  end

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
