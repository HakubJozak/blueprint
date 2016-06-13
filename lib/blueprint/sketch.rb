require_relative 'dsl/plain_attribute'
require_relative 'dsl/belongs_to_attribute'
require_relative 'dsl/has_many_field'
require_relative 'dsl/model'


class Blueprint::Sketch
  def initialize(file = Rails.root.join('db/blueprint.rb').to_s)
    @dsl = Dsl.new
    @dsl.instance_eval(File.read(file),file)
  end

  def models
    @dsl.models
  end

  def find!(name)
    @dsl.models.fetch name.to_sym
  end

  class Dsl
    attr_reader :models

    def initialize
      @models = {}
    end

    def model(name,&block)
      @models[name] = ::Blueprint::Dsl::Model.new(name)
      @models[name].instance_eval(&block) if block
    end
  end
end
