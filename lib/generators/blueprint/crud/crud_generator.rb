class Blueprint::CrudGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_controller_class
    template "controller.rb.erb",
             File.join('app/controllers', controller_file_name)

  end

  def create_controller_test
    template "test.rb.erb",
             File.join('test/controllers', test_file_name)
  end

  def create_views
    %w( edit index new _form ).each do |view|
      template "#{view}.slim.erb",
               File.join("app/views/#{name}s", "#{view}.slim")
    end

    # HACK has many - rewrite
    # blueprint.fields.each do |f|
    #   if f.try(:model)
    #     old = @blueprint
    #     @blueprint = f.model
    #     template "_form.slim.erb",
    #              File.join("app/views/#{name}s", "_#{f.name}_form.slim")
    #     @blueprint = old
    #   end
    # end
  end

  protected

  def blueprint
    @blueprint ||= sketch.find!(singular_name)
  end

  delegate :fields, :fields_whitelist, to: :blueprint

  def sketch
    @sketch ||= Blueprint::Sketch.new
  end

  def index_scope
    'order(:created_at).page(current_page)'
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

  def edit_path(r = singular_instance)
    "edit_#{table_name.singularize}_path(#{r})"
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

  def plural_instance
    "@#{plural_name}"
  end

  def respond_with(var)
    if name =~ %r{(\w+)/(\w+)}
      # namespaced
      "respond_with :#{$1}, #{var}"
    else
      "respond_with #{var}"
    end
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

  # Test helpers

  def test_file_name
    "#{name}s_controller_test.rb"
  end



end
