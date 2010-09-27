require 'rails/generators'

module ConfigatronRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path(File.join(File.dirname(__FILE__), 'templates'))

      def install
        template "config.yml.erb", "config/config.yml"
        template "load_config.rb", "config/initializers/load_config.rb"
      end

      private
      def environments
        yml = File.join(Rails.root, "config", "database.yml")
        YAML.load_file(yml).keys
      end
    end
  end
end

