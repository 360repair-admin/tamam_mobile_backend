module Api
  module V1
    class ProfileController < Api::BaseController
      def show
        render json: { customer: current_customer }
      end

      def update
        current_customer.update!(profile_params)
        render json: { customer: current_customer }
      end

      def destroy
        current_customer.update!(deleted_at: Time.current)
        render json: { message: "Account deleted successfully" }, status: :ok
      end

      private

      def profile_params
        params.permit(:full_name, :email, :locale)
      end
    end
  end
end
