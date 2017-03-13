class Blueprint::AdminGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)


  def create_files
    empty_directory 'app/views/admin'
    empty_directory 'app/controller/admin'
    empty_directory 'app/assets/javascripts/admin'
    empty_directory 'app/assets/stylesheets/admin'            

    copy_file 'admin.scss', 'app/assets/stylesheets/admin.scss'
    copy_file 'admin.coffee', 'app/assets/javascripts/admin.coffee'
    copy_file 'base_controller.rb', 'app/controllers/admin/base_controller.rb'
    copy_file '_flash.slim', 'app/views/admin/_flash.slim'
    copy_file '_topbar.slim', 'app/views/admin/_topbar.slim'
    copy_file 'layout.slim', 'app/views/layouts/admin.slim'    
  end

  def routes
    unless File.new('config/routes.rb').read =~
             /namespace\s+:admin\s+do/
      inject_admin_namespace
    end
  end

  private

  def inject_admin_namespace
    admin_block =
      """
  namespace :admin do
  end
      """
    
    inject_into_file "config/routes.rb", admin_block, before: /^end/
  end
  

end
