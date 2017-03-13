class Blueprint::CrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)


  def create_files
    empty_directory 'app/views/admin'
    empty_directory 'app/controller/admin'
    empty_directory 'app/assets/javascripts/admin'
    empty_directory 'app/assets/stylesheets/admin'            

    copy_file 'admin.scss', 'app/assets/stylesheets'
    copy_file 'admin.coffee', 'app/assets/javascripts'
    copy_file 'base_controller', 'app/controllers/admin'

    copy_file '_flash.slim', 'app/views/admin'
    copy_file '_topbar.slim', 'app/views/admin'
    copy_file 'layout.slim', 'app/views/layouts/admin.slim'    
  end

end
