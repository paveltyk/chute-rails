require 'rails'
require 'rails/generators/migration'

module Chute
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path('../templates', __FILE__)
      desc "add db migrations for chute models"

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def copy_migrations
        migration_template "create_gc_assets.rb", "db/migrate/create_gc_assets.rb"
        migration_template "create_gc_chutes.rb", "db/migrate/create_gc_chutes.rb"
      end
    end
  end
end
