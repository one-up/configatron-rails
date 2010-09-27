require 'test_helper'

class ConfigatronRails::Generators::InstallGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests ConfigatronRails::Generators::InstallGenerator
  arguments []

  setup :prepare_destination
  setup :copy_database_yml

  test "should create configatron files" do
    run_generator
    assert_file "config/config.yml", /^development:/
    assert_file "config/initializers/load_config.rb", %r[configatron.configure_from_yaml\("\#{Rails.root}]
  end

end
