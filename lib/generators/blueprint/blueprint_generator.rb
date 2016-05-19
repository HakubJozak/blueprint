class BlueprintGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

#  argument :file, type: :string, default: Rails.root.join('db/blueprint.rb')

  def create_models
    Blueprint.read.each_value do |m|
      m.run_crud_generator!(self)
    end
  end
  
end
