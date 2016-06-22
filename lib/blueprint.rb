require "blueprint/engine"
require "blueprint/sketch"
require "blueprint/filterable"
require "blueprint/sortable"
require "blueprint/helpers"

# helpers = "#{File.dirname(__FILE__)}/blueprint/helpers/*.rb"
# Dir[helpers].each { |h| require_relative h }

module Blueprint
  extend ActiveSupport::Autoload

  autoload :Helpers
end
