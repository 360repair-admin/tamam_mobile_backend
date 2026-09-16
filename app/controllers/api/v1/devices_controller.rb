class Api::V1::DevicesController < Api::BaseController
  def index
    render json: { devices: current_customer.devices }
  end

  def create
    device = current_customer.devices.find_or_initialize_by(
      token: device_params[:token]
    )

    device.assign_attributes(device_params)
    device.last_seen_at = Time.current

    if device.save
      render json: { device: device }, status: :created
    else
      render json: { errors: device.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    device = current_customer.devices.find(params[:id])
    device.destroy!

    head :no_content
  end

  private

  def device_params
    params.require(:device).permit(
      :token,
      :platform,
      :device_id,
      :app_version
    )
  end
end
