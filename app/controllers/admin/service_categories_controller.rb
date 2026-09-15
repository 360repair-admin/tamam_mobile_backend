class Admin::ServiceCategoriesController < Admin::BaseController
  before_action :set_service_category, only: :show

  def index
    @service_categories = ServiceCategory.order(:name_en)
  end

  def show
  end

  private

  def set_service_category
    @service_category = ServiceCategory.find(params[:id])
  end
end
