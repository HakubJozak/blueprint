class Blueprint::CloneGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../../../../..', __FILE__)

  def clone_helpers
    return unless part.helpers?
    directory "app/helpers/blueprint"
  end

  def clone_views
    return unless part.views?
    directory "app/views/blueprint"
  end

  def clone_crud
    return unless part.crud?
    directory "lib/generators/blueprint/crud"
  end

  def clone_concerns
    return unless part.concerns?
    directory "app/controllers/concerns/blueprint"
    clone "lib/blueprint/filterable.rb"
    clone "lib/blueprint/sortable.rb"    
  end  

  private

  def part
    if name.downcase == 'all'
      YesSir.new
    else
      ActiveSupport::StringInquirer.new(name)
    end
  end
  
  def clone(filename)
    copy_file filename, filename
  end

  def blueprint_root
    File.expand_path('../../../../..', __FILE__)    
  end

  class YesSir
    def method_missing(*args)
      true
    end
  end
end
