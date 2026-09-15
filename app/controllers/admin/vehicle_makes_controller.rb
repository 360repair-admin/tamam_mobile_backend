class Admin::VehicleMakesController < Admin::BaseController
  before_action :set_vehicle_make, only: :show

  def index
    @vehicle_makes = VehicleMake.order(:name_en)
  end

  def show
    @vehicle_models = @vehicle_make.vehicle_models.order(:name_en)
  end

  private

  def set_vehicle_make
    @vehicle_make = VehicleMake.find(params[:id])
  end
end
