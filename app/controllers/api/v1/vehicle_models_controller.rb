class Api::V1::VehicleModelsController < Api::BaseController
  def index
    vehicle_models = VehicleModel
      .where(vehicle_make_id: params[:vehicle_make_id])
      .order(:id)

    render json: vehicle_models.map { |vehicle_model|
      {
        id: vehicle_model.id,
        name_en: vehicle_model.name_en,
        name_ar: vehicle_model.name_ar
      }
    }
  end
end
