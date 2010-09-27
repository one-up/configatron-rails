require 'rubygems'
require 'test/unit'
require 'rails/all'
require 'rails/generators'
require 'rails/generators/test_case'

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
end
Rails.application = TestApp

module Rails
  def self.root
    @root ||= File.expand_path(File.join(File.dirname(__FILE__), '..', 'tmp', 'rails'))
  end
end
Rails.application.config.root = Rails.root

Rails::Generators.configure!

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

def copy_database_yml
  databaseyml = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures', 'database.yml'))
  destination = File.join(Rails.root, "config")
  FileUtils.mkdir_p(destination)
  FileUtils.cp File.expand_path(databaseyml), destination
end

def generator_list
  {
    :configatron_rails => %w[ install ],
  }
end

def path_prefix(name)
  name == :rails ? 'rails/generators' : 'generators'
end

def require_generators(generator_list)
  generator_list.each do |name, generators|
    generators.each do |generator_name|
      require File.join(path_prefix(name), name.to_s, generator_name.to_s, "#{generator_name}_generator")
    end
  end
end
alias require_generator require_generators

require_generators generator_list

