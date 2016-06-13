class Blueprint::ModelGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def delegate_to_rails
    if name == 'all'
      all_models
    else
      one_model(name)
    end
  end

  private

  def all_models
    sketch.models.each_value do |m|
      one_model(m.name.to_s)
    end
  end
  
  def one_model(name)
    model = sketch.find!(name.to_sym)
    fields = model.fields.map(&:to_arg)
    call! 'model', [ model.name.to_s, fields.compact ]    
  end

  def sketch
    Blueprint::Sketch.new    
  end
  
  def call!(name,args)
    with_padding do
      opts = { behavior: behavior }
      opts.merge!(options)

      force = opts['force'] ? '--force' : nil
      ignore = opts['skip'] ? '--skip' : nil      
      
      run_rails_generator! name, [ args, force, ignore ], opts    
    end
  end

  def run_rails_generator!(generator_name, args, opts)
    action = (behavior == :invoke)? 'generate' : 'destroy'
    say! [ "rails #{action}", generator_name, args ].flatten.join(' ') + "\n"      
    ::Rails::Generators.invoke generator_name, [ args ].flatten, opts
  end
  

  def say!(msg)
    say "#{@name.to_s.capitalize} - #{msg}", output_color
  end

  def output_color
    if behavior == :invoke
      :green
    else # == :revoke
      :red
    end
  end  
  
end
