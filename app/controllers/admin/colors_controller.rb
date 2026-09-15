class Admin::ColorsController < Admin::BaseController
  before_action :set_color, only: %i[show edit update destroy]

  def index
    @colors = Color.order(:name_en)
  end

  def show
  end

  def new
    @color = Color.new
  end

  def create
    @color = Color.new(color_params)

    if @color.save
      redirect_to admin_colors_path, notice: "Color created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @color.update(color_params)
      redirect_to admin_colors_path, notice: "Color updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @color.destroy
      redirect_to admin_colors_path, notice: "Color deleted successfully."
    else
      redirect_to admin_colors_path,
        alert: @color.errors.full_messages.to_sentence
    end
  end

  private

  def set_color
    @color = Color.find(params[:id])
  end

  def color_params
    params.require(:color).permit(:name_ar, :name_en)
  end
end
