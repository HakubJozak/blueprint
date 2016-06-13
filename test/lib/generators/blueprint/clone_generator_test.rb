require 'test_helper'
require 'generators/blueprint/clone/clone_generator'

class Blueprint::CloneGeneratorTest < Rails::Generators::TestCase
  tests Blueprint::CloneGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  # test "generator runs without errors" do
  #   assert_nothing_raised do
  #     run_generator ["arguments"]
  #   end
  # end
end
