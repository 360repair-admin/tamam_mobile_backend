module Api
  module V1
    class AddressesController < Api::BaseController
      def index
        render json: current_customer.addresses
      end

      def create
        address = current_customer.addresses.create!(address_params)

        render json: address, status: :created
      end

      def update
        address = current_customer.addresses.find(params[:id])
        address.update!(address_params)

        render json: address
      end

      private

      def address_params
        params.require(:address).permit(
          :city_id,
          :address_line,
          :is_default
        )
      end
    end
  end
end
