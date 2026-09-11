module Faulty
  class ApplicationController < ::ApplicationController
    layout "faulty/application"

    before_action :authorize_faulty_dashboard!

    private

    def authorize_faulty_dashboard!
      return unless Faulty.enabled_authorization

      user = Faulty.current_faulty_user.call(self)

      if user.blank?
        return redirect_to Rails.application.routes.url_helpers.root_path, alert: "Current user is not found"
      end

      unless Faulty.resolved_authorized_users.include?(user)
        return redirect_to Rails.application.routes.url_helpers.root_path, alert: "You are not authorized to access this page"
      end
    end
  end
end
