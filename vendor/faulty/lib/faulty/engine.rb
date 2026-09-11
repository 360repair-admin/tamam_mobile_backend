require "faulty/middleware"
require "faulty/job_tracker"

module Faulty
  class Engine < ::Rails::Engine
    isolate_namespace Faulty

    # Middleware registration
    initializer "faulty.middleware" do |app|
      app.config.middleware.use Faulty::Middleware
    end

    # Precompile the gem's CSS for dashboard
    initializer "faulty.assets.precompile" do |app|
      app.config.assets.precompile += %w[
        faulty/dashboard.css
        faulty/dashboard.js
      ]
    end

    # Include helpers
    initializer "faulty.helpers" do
      ActiveSupport.on_load(:action_controller) do
        helper Faulty::ApplicationHelper
      end
    end

    # inside Faulty::Engine
    initializer "faulty.active_job" do
      ActiveSupport.on_load(:active_job) do
        ::ActiveJob::Base.include Faulty::JobTracker
      end
    end

  end
end
