module Blueprint::FilteringHelper

  def filter_form(url = {}, opts = {}, &block)
    opts.reverse_merge!(id: 'filter-form',class: 'form', method: :get)
    form_tag(url, opts, &block)
  end

  def query_field(placeholder)
    text_field_tag :by_query, query,
                   class: 'form-control',
                   placeholder: placeholder
  end

  def state_select_options(model)
    opts = model.group(:state).count.map { |state,count|
      name = t("states.#{model.name}.#{state}")
      [ name, state ]
    }
    options_for_select(opts, filter_params[:with_state])
  end

  def state_filter_select(model)
    select_tag :with_state,
               state_select_options(model),
               class: 'form-control',
               include_blank: t("states.#{model.name}.all")
  end

  def array_select(array, param_name, opts = {})
    value = filter_params[param_name]

    opts.reverse_merge!(class: 'form-control',
                        include_blank: true)
    
    select_tag param_name,
               options_for_select(array, value),
               opts
  end

  def model_select(model, param_name, opts = {})
    records = model.all.ordered.map { |y| [y.to_label, y.id ] }
    value = filter_params[param_name]

    opts.reverse_merge!(class: 'form-control',
                        include_blank: true)
    
    select_tag param_name,
               options_for_select(records, value),
               opts
  end
  

end
