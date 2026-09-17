class Api::V1::VehicleMakesController < Api::BaseController
  def index
    vehicle_makes = VehicleMake.order(:id)

    render json: vehicle_makes.map { |vehicle_make|
      {
        id: vehicle_make.id,
        name_en: vehicle_make.name_en,
        name_ar: vehicle_make.name_ar
      }
    }
  end
end
