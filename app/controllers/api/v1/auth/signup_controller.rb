class Api::V1::Auth::SignupController < Api::BaseController
  skip_before_action :authenticate_customer!

  def create
    if signup_params[:phone_number].blank?
      return render_error(
        "invalid_phone_number",
        "Phone number is required"
      )
    end
  
    phone_number = PhoneNumber.normalize(signup_params[:phone_number])
  
    unless PhoneNumber.valid?(phone_number)
      return render_error(
        "invalid_phone_number",
        "Phone number must be a valid Saudi mobile number"
      )
    end
  
    unless signup_params[:terms_accepted] == true
      return render_error(
        "terms_not_accepted",
        "Terms and conditions must be accepted"
      )
    end
  
    customer = Customer.find_by(phone_number: phone_number)
  
    if customer
      if customer.deleted_at.present?
        return render_error(
          "customer_deactivated",
          "This account has been deactivated"
        )
      end
  
      if customer.phone_number_verified_at.present?
        return render_error(
          "customer_already_exists",
          "A customer with this phone number already exists"
        )
      end
    else
      customer = Customer.new(phone_number: phone_number)
    end
  
    customer.full_name = signup_params[:username]
    customer.terms_accepted_at = Time.current
    customer.save!
  
    otp_response = Otp::Request.call(
      phone_number: customer.phone_number,
      purpose: "signup"
    )
  
    render json: otp_response, status: :accepted
  end

  private

  def signup_params
    params.permit(
      :username,
      :phone_number,
      :terms_accepted
    )
  end

  def render_error(code, message)
    render json: {
      error: {
        code: code,
        message: message
      }
    }, status: :unprocessable_entity
  end
end
