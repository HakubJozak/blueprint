require 'test_helper'
require 'generators/blueprint/model/model_generator'

class Blueprint::ModelGeneratorTest < Rails::Generators::TestCase
  tests Blueprint::ModelGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
