class Api::V1::VehiclesController < Api::BaseController
  before_action :set_vehicle, only: %i[show update destroy]

  def index
    @vehicles = current_customer.vehicles.includes(
      vehicle_model: :vehicle_make,
      color: {}
    )

    render json: @vehicles
  end

  def show
    render json: @vehicle
  end

  def create
    @vehicle = current_customer.vehicles.build(vehicle_params)

    if @vehicle.save
      render json: @vehicle, status: :created
    else
      render json: { errors: @vehicle.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @vehicle.update(vehicle_params)
      render json: @vehicle
    else
      render json: { errors: @vehicle.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @vehicle.destroy!

    head :no_content
  end

  private

  def set_vehicle
    @vehicle = current_customer.vehicles.find(params[:id])
  end

  def vehicle_params
    params.require(:vehicle).permit(
      :plate_number,
      :plate_left_letter,
      :plate_middle_letter,
      :plate_right_letter,
      :vehicle_model_id,
      :manufacturing_year,
      :color_id,
      :chassis_number
    )
  end
end
