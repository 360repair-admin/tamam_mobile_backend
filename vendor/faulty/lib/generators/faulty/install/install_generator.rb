require "rails/generators"
require "rails/generators/migration"

module Faulty
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path("templates", __dir__)

      def self.next_migration_number(dirname)
        if ActiveRecord::Base.respond_to?(:timestamped_migrations) && ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          format("%03d", current_migration_number(dirname) + 1)
        end
      end

      def copy_migrations
        migration_template "create_faulty_tables.rb", "db/migrate/create_faulty_tables.rb"
      end

      def copy_initializer
        template "faulty.rb", "config/initializers/faulty.rb"
      end
    end
  end
end
