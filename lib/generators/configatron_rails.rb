require 'rails/generators/named_base'

module ConfigatronRails
  module Generators
    class Base < Rails::Generators::NamedBase
      def self.source_root
        @_configatron_source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'configatron', 'templates'))
      end
    end
  end
end

