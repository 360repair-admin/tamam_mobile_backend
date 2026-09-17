class Api::V1::ColorsController < Api::BaseController
  def index
    colors = Color.order(:id)

    render json: colors.map { |color|
      {
        id: color.id,
        name_en: color.name_en,
        name_ar: color.name_ar
      }
    }
  end
end
