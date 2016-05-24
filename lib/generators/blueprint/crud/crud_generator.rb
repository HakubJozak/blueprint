class Blueprint::CrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_files
    models = Blueprint::Sketch.new.models
    @blueprint = models[singular_name.to_sym] || Blueprint::Model.new(name.to_sym)

    template "controller.rb.erb",
             File.join('app/controllers', controller_file_name)

    %w( edit index new _form ).each do |view|
      template "#{view}.slim.erb",
               File.join("app/views/#{name}s", "#{view}.slim")
    end

    # HACK has many - rewrite
    @blueprint.fields.each do |f|
      if f.try(:model)
        old = @blueprint
        @blueprint = f.model
        template "_form.slim.erb",
                 File.join("app/views/#{name}s", "_#{f.name}_form.slim")
        @blueprint = old
      end
    end
  end

  protected

  attr_reader :blueprint
  delegate :fields, :fields_whitelist, to: :blueprint

  def index_scope
    if blueprint.has_zone?
      'order(:created_at).page(current_page).by_zone(@zone)'
    else
      'order(:created_at).page(current_page)'
    end
  end

  def model_class
    class_name.demodulize
  end

  def resource_path_for(variable)
    "#{singular_table_name}_path(#{variable}.id)"
  end

  def index_path
    "#{table_name}_path"
  end

  def new_path
    "new_#{table_name.singularize}_path"    
  end

  def show_path(r = singular_instance)
    "#{table_name.singularize}_path(#{r})"    
  end

  def parent_controller
    if class_name =~ /(^.*::)/
      "#{$1}BaseController"
    else
      'ApplicationController'
    end
  end

  def singular_instance
    "@#{singular_name}"
  end

  def find_method
    "find_#{singular_name}"
  end

  def params_method
    "#{singular_name}_params"
  end

  def controller_name
    "#{class_name}sController"
  end

  def controller_file_name
    "#{name}s_controller.rb"
  end

end
