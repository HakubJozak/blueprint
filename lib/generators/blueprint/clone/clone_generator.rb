class Blueprint::CloneGenerator < Rails::Generators::Base
  source_root File.expand_path('../../../../..', __FILE__)

  def clone_files
    directory "lib/generators/blueprint/crud"
    directory "app/views/blueprint"
    directory "app/helpers/blueprint"
    directory "app/controllers/concerns/blueprint"
  end

  private
  
  def clone(filename)
    copy_file filename, filename
  end

  def blueprint_root
    File.expand_path('../../../../..', __FILE__)    
  end
end
